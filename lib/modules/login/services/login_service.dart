import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import the GetX library for navigation.
import 'package:sunflower_tools/modules/login/controllers/login_controller.dart';
import 'package:sunflower_tools/modules/shared/controllers/farm_controller.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/config/farm_service.dart';

class LoginService {
  // Controller to manage and store login information
  final FarmController farmController = Get.find<FarmController>();
  final LoginController loginController = Get.find<LoginController>();

  final FarmService farmService = FarmService();

  // Function to make the login that returns a code of success or error
  Future enterFarm(BuildContext context) async {
    try {
      // Perform the initial fetch to check if the farmland data exists
      int statusCode = await farmService.performInitialFetchIfNeeded(
          int.parse(loginController.userLandId.text));

      // If the farmland data exists and is valid, redirect to HomePage
      if (statusCode == 200) {
        LocalSecureData.saveSecureData('farm', loginController.userLandId.text);
        LocalSecureData.saveSecureData(
            'refreshTime', loginController.refreshTime.text);

        Get.offAndToNamed(
            '/homePage'); // Assuming you have a route named '/home'
      } else {
        // Handle case where farmland data is not valid
        Get.snackbar('Error', 'Failed to load farm data.');
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
