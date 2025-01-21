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

  void startWokmanagerTask(int farmID) async {
    // Cancel any existing timer
    _timer?.cancel();

    // Perform initial fetch and get the status code if needed
    listInventory.value = performInitialFetchIfNeeded(farmID);

    // Start a new periodic timer

    log('Fetching data from the server...');

    listInventory.value =
        getData(farmID); // Call the getData function periodically
  }
  // void startPeriodicTask() async {

  //   // Return the status code from the initial fetch
  // }

  // Stop the periodic task
  void stopPeriodicTask() {
    _timer?.cancel(); // Cancel the existing timer
  }

  // Function to fetch data from the API
  Future<int> getData(int farmID) async {
    try {
      final response =
          await InterceptorConfig().dio.get('$baseUrl$module$farmID');

      // Verifique se a resposta é válida antes de continuar
      if (response == null) {
        return Future.error('No response from the server');
      }

      // Verifique se statusCode está presente e é válido
      if (response.statusCode == null) {
        return Future.error('Invalid status code (null)');
      }

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
          return Future.error('Response data is null');
        }
      } else {
        return Future.error('Unexpected status code: ${response.statusCode}');
      }

      return response.statusCode ??
          500; // Retorna o statusCode, ou 500 se for nulo.
    } catch (error) {
      return Future.error(error.toString());
    }
  }

  // Function to perform the initial fetch if needed
  Future<int> performInitialFetchIfNeeded(int farmID) async {
    final String? lastRequestTime =
        await LocalSecureData.readSecureData(lastRequestKey);

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
    listInventory.value = getData(farmID);
    await LocalSecureData.saveSecureData(
        lastRequestKey, DateTime.now().millisecondsSinceEpoch.toString());
    return listInventory.value!;
  }

  // Function to save the timestamp of the last request
  Future<void> saveLastRequestTime() async {
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    await LocalSecureData.saveSecureData(
        lastRequestKey, currentTime.toString());
  }
}
