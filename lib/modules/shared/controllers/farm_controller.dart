import 'package:get/get.dart'; // Imports the GetX library for state management.
import 'package:sunflower_tools/modules/shared/controllers/grouped_controller.dart';

class FarmController extends GetxController {
  // Maps to store farm, crops, inventory, and previous inventory data.
  final GroupedController groupedController = Get.find<GroupedController>();

  Map<String, dynamic> farmData = {};
  Map<String, dynamic> cropsData = {};
  Map<String, dynamic> inventoryData = {};
  Map<String, dynamic> previousInventoryData = {};
  Map<String, dynamic> treesData = {}; // New map to store trees data.
  Map<String, dynamic> stonesData = {}; // New map to store stones data.
  Map<String, dynamic> ironData = {}; // New map to store iron data.
  Map<String, dynamic> goldData = {}; // New map to store gold data.
  Map<String, dynamic> crimstoneData = {}; // New map to store crimstone data.
  Map<String, dynamic> oilReserveData = {}; // New map to store oil data.
  Map<String, dynamic> sunstoneData = {}; // New map to store sunstone data.
  Map<String, dynamic> fruitPatchesData = {}; // New map to store fruit data.
  Map<String, dynamic> flowerData = {}; // New map to store flower data.

  // Asynchronous function to get farm data from the provided body.
  Future<void> getFarm({required Map<String, dynamic> body}) async {
    if (body.containsKey('farm')) {
      // Update farm data.
      farmData = body['farm'];
      // Extract crops data from farm data.
      cropsData = farmData['crops'];
      // Extract trees data from farm data.
      treesData = farmData['trees'];
      // Extract stones data from farm data.
      stonesData = farmData['stones'];
      // Extract irons data from farm data.
      ironData = farmData['iron'];
      // Extract gold data from farm data.
      goldData = farmData['gold'];
      // Extract crimstone data from farm data.
      crimstoneData = farmData['crimstones'];
      // Extract oil data from farm data.
      oilReserveData = farmData['oilReserves'];
      // Extract sunstone data from farm data.
      sunstoneData = farmData['sunstones'];
      // Extract fruit data from farm data.
      fruitPatchesData = farmData['fruitPatches'];
      // Extract flower data from farm data.
      flowerData = farmData['flowers'];

      // Update fields using the crops data.
      groupedController.updateFieldsFromJson(cropsData);
      // Update trees using the trees data.
      groupedController.updateTreesFromJson(treesData);
      // Update stones using the stones data.
      groupedController.updateStonesFromJson(stonesData);
      // Update iron using the iron data.
      groupedController.updateIronsFromJson(ironData);
      // Update gold using the gold data.
      groupedController.updateGoldsFromJson(goldData);
      // Update crimstone using the crimstone data.
      groupedController.updateCrimstonesFromJson(crimstoneData);
      // Update oil using the oil data.
      groupedController.updateOilReservesFromJson(oilReserveData);
      // Update sunstone using the sunstone data.
      groupedController.updateSunstonesFromJson(sunstoneData);
      // Update fruit using the fruit data.
      groupedController.updateFruitPatchesFromJson(fruitPatchesData);
      // Update fruit using the flower data.
      groupedController.updateFlowerBedsFromJson(flowerData);
    } else {
      // Throw an exception if the body does not contain 'farm'.
      throw Exception('Expected body to contain farm');
    }
  }
}
