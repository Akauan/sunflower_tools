import 'package:get/get.dart'; // Imports the GetX library for state management.

class PricesController extends GetxController {
  // Maps to store farm, crops, inventory, and previous inventory data.

  Map<String, dynamic> pricesData = {};
  Map<String, dynamic> p2pPrices = {};
  Map<String, dynamic> seqPrices = {};
  Map<String, dynamic> gePrices = {};

  // Asynchronous function to get farm data from the provided body.
  Future<void> getPrices({required Map<String, dynamic> body}) async {
    // Update sfl data.
    pricesData = body['data'];
    // Extract pol data from farm data.
    p2pPrices = pricesData['p2p'];

    // Extract gems data from farm data.
    seqPrices = pricesData['seq'];
    // Extract stones data from farm data.
    gePrices = pricesData['ge'];
  }
}
