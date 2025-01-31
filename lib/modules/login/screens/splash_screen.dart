import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sunflower_tools/modules/login/controllers/login_controller.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Initializing controllers
  final LoginController _loginController = Get.find<LoginController>();

  // This function is called when this object is inserted into the tree.
  @override
  void initState() {
    super.initState();

    // Start the animation
    _startAnimation();

    // Call the _functionTimeEnd function after a delay of 2 seconds
    Timer(const Duration(seconds: 2), _functionTimeEnd);
  }

// This function is called when this object is removed from the tree permanently.
  @override
  void dispose() {
    super.dispose();
  }

// A boolean observable that tracks whether the animation is showing
  final Rx<bool> _isShowing = false.obs;

// This function starts the animation after a delay
  Future<void> _startAnimation() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
      () {
        // Set the _isShowing value to true after the delay
        _isShowing.value = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(color: ThemeColor.whiteColor),
        child: Center(
          child: Obx(
            () => AnimatedOpacity(
              opacity: _isShowing.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1300),
              child: Lottie.asset(
                'assets/jsons/loading.json',
              ),
            ),
          ),
        ),
      ),
    );
  }

  _functionTimeEnd() async {
    // If the user is already logged in
    if (await SharedData.isLogged()) {
      // Uses user credentials to access the system automatically
      _loginController.userLandId.text =
          await SharedData.readSecureData('farm');
      _loginController.refreshTime.text =
          await SharedData.readSecureData('refreshTime');

      Get.offAndToNamed('/homePage');
    }
    // If the user is not logged in
    else {
      // Back to login screen
      Get.offAndToNamed('/loginPage');
    }
  }
}
