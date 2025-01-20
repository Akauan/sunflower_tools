import 'package:get/get.dart'; // Imports the GetX library for state management.

class ExchangeController extends GetxController {
  // Maps to store farm, crops, inventory, and previous inventory data.

  Map<String, dynamic> sflValues = {};
  Map<String, dynamic> polValues = {};
  Map<String, dynamic> inventoryData = {};
  Map<String, dynamic> previousInventoryData = {};
  Map<String, dynamic> gemValues = {};
  Map<String, dynamic> coinsValue = {};

  // Asynchronous function to get farm data from the provided body.
  Future<void> getExchange({required Map<String, dynamic> body}) async {
    // Update sfl data.
    sflValues = body['sfl'];
    // Extract pol data from farm data.
    polValues = body['pol'];
    // Extract gems data from farm data.
    gemValues = body['gems'];
    // Extract stones data from farm data.
    coinsValue = body['coins'];
  }
}
