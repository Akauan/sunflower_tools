import 'dart:async'; // Import the async library to use Timer.
import 'dart:convert'; // Import for jsonDecode function.
import 'package:get/get.dart'; // Import the GetX library for state management.
import 'package:sunflower_tools/modules/shared/controllers/farm_controller.dart'; // Import the farm controller.
import 'package:sunflower_tools/modules/shared/config/interceptor.dart'; // Import the interceptor configuration.
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart'; // Import the local secure data.

class FarmService {
  final FarmController farmController = Get.find<FarmController>();

  // Set [baseUrl] with the API IP
  final String baseUrl = const String.fromEnvironment('BASEURL');

  // The path for authentication
  final String module = 'farms/';

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

  // Start the periodic task
  Future<int> startPeriodicTask(int farmID) async {
    // Cancel any existing timer
    _timer?.cancel();

    // Perform initial fetch and get the status code if needed
    final int initialStatusCode = await performInitialFetchIfNeeded(farmID);

    // Start a new periodic timer
    _timer =
        Timer.periodic(Duration(minutes: intervalMinutes.value), (timer) async {
      await getData(farmID); // Call the getData function periodically
    });

    // Return the status code from the initial fetch
    return initialStatusCode;
  }

  // Stop the periodic task
  void stopPeriodicTask() {
    _timer?.cancel(); // Cancel the existing timer
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
        Future.error(response.data);
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
