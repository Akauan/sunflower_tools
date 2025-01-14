import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/interceptor.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/controllers/farm_controller.dart';

class FarmService {
  final FarmController farmController = Get.find<FarmController>();

  // Set [baseUrl] with the API IP
  final String baseUrl = const String.fromEnvironment('BASEURL');
  final String module = 'farms/'; // The path for the farm module

  // Timer for periodic execution
  Timer? _timer;

  // Variable for the interval duration in minutes
  RxInt intervalMinutes = 10.obs;

  // Store the previous data to compare with new data
  Map<String, dynamic>? previousData;

  // Key for storing the timestamp of the last request
  final String lastRequestKey = 'lastRequestTime';

  // Key for storing the farm data
  final String farmDataKey = 'farmData';

  // Stream controller for emitting updates
  final StreamController<int> streamController =
      StreamController<int>.broadcast();

  // Start the periodic task and return a Stream
  Stream<int> startPeriodicTask(int farmID) {
    // Perform initial fetch and emit the status code
    performInitialFetchIfNeeded(farmID).then((statusCode) {
      streamController
          .add(statusCode); // Emit the initial data after the first fetch
    });

    // Start a periodic task to emit data every minute
    _timer =
        Timer.periodic(Duration(minutes: intervalMinutes.value), (timer) async {
      final statusCode = await getData(farmID);
      streamController
          .add(statusCode); // Emit the status code whenever data is fetched
    });

    // Return the stream for the UI to listen to
    return streamController.stream;
  }

  // Stop the periodic task
  void stopPeriodicTask() {
    _timer?.cancel(); // Cancel the existing timer
    streamController.close(); // Close the stream when no longer needed
  }

  // Function to fetch data from the API
  Future<int> getData(int farmID) async {
    try {
      final response =
          await InterceptorConfig().dio.get('$baseUrl$module$farmID');

      // If the returned code is a success, the access is granted
      if (response.statusCode == 200) {
        Map<String, dynamic> newData = response.data;

        // Check if the new data is different from the previous data
        if (previousData == null ||
            previousData.toString() != newData.toString()) {
          previousData = newData; // Update the previous data
          await farmController.getFarm(
              body: newData); // Update the farm controller
          await saveLastRequestTime(); // Save the timestamp of this request
          await LocalSecureData.saveSecureData(
              farmDataKey, jsonEncode(response.data)); // Save farm data
        }
      } else {
        return Future.error(response.data);
      }
      return response.statusCode;
    } catch (error) {
      return Future.error(error);
    }
  }

  // Function to perform the initial fetch if needed
  Future<int> performInitialFetchIfNeeded(int farmID) async {
    final String? lastRequestTime =
        await LocalSecureData.readSecureData(lastRequestKey);
    final String? savedData = await LocalSecureData.readSecureData(farmDataKey);

    if (savedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(savedData);
      await farmController.getFarm(body: decodedData); // Load saved farm data
    }

    if (lastRequestTime != null) {
      final int lastRequestTimestamp = int.parse(lastRequestTime);
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      final int elapsedSeconds = (currentTime - lastRequestTimestamp) ~/ 1000;

      // Check if the elapsed time since the last request is less than 10 seconds
      if (elapsedSeconds < 10) {
        return 200; // Return success status code without making a new request
      }
    }

    // Make a new request and update the last request timestamp
    final result = await getData(farmID);
    await LocalSecureData.saveSecureData(
        lastRequestKey, DateTime.now().millisecondsSinceEpoch.toString());
    return result;
  }

  // Function to save the timestamp of the last request
  Future<void> saveLastRequestTime() async {
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    await LocalSecureData.saveSecureData(
        lastRequestKey, currentTime.toString());
  }
}
