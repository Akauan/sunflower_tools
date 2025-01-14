import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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

  final Rx<Future<int>?> listInventory = Rx<Future<int>?>(null);

  // Start the periodic task and return a Stream
  // Atualize o método `startPeriodicTask` para garantir que ele seja robusto:

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
      log('Fetching data for farmID: $farmID');

      final response =
          await InterceptorConfig().dio.get('$baseUrl$module$farmID');

      // Verifique se a resposta é válida antes de continuar
      if (response == null) {
        log('Error: Response is null');
        return Future.error('No response from the server');
      }

      // Verifique se statusCode está presente e é válido
      if (response.statusCode == null) {
        log('Error: statusCode is null');
        return Future.error('Invalid status code (null)');
      }

      log('Response received. Status code: ${response.statusCode}');

      // Se a resposta for um sucesso (statusCode 200)
      if (response.statusCode == 200) {
        if (response.data != null) {
          Map<String, dynamic> newData = response.data;

          // Verifique se os dados são diferentes dos dados anteriores
          if (previousData == null ||
              previousData.toString() != newData.toString()) {
            previousData = newData; // Atualizar os dados anteriores
            await farmController.getFarm(
                body: newData); // Atualizar o farmController com os novos dados
            await saveLastRequestTime(); // Salvar o timestamp da solicitação
            await LocalSecureData.saveSecureData(farmDataKey,
                jsonEncode(response.data)); // Salvar os dados do farm
          }
        } else {
          log('Error: Response data is null');
          return Future.error('Response data is null');
        }
      } else {
        log('Error: Received an unexpected status code: ${response.statusCode}');
        return Future.error('Unexpected status code: ${response.statusCode}');
      }

      return response.statusCode ??
          500; // Retorna o statusCode, ou 500 se for nulo.
    } catch (error) {
      log('Error occurred: ${error.toString()}');
      return Future.error(error.toString());
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
        log('Elapsed time: $elapsedSeconds seconds');
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
