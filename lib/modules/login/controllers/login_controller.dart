import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

class LoginController extends GetxController {
  final TextEditingController userLandId = TextEditingController();
  final TextEditingController refreshTime = TextEditingController();

  // Clear login controllers
  clearVariables() {
    userLandId.text = '';
  }

  clearField(TextEditingController field, RxBool validator) {
    if (!validator.value) {
      field.text = '';
    }
  }
}
