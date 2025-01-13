import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

class CooldownController extends GetxController {
  var cooldownTime =
      0.obs; // Observable variable for the cooldown time in seconds.
  var isCooldownActive =
      false.obs; // Observable variable to indicate if the cooldown is active.
  Timer? _timer; // Variable to store the Timer.

  // Function to start the cooldown with a specific time in seconds.
  void startCooldown(int cooldown, String itemTitle) {
    if (isCooldownActive.value) return;

    // Set the cooldown time, ensuring it is not negative.
    cooldownTime.value = cooldown < 0 ? 0 : cooldown;

    isCooldownActive.value = true; // Set the cooldown as active.

    // Start a timer that decrements the cooldown time every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (cooldownTime.value > 0) {
        cooldownTime.value--; // Decrement the cooldown time.
      } else {
        cooldownTime.value = 0; // Ensure cooldownTime does not go below 0.
        isCooldownActive.value =
            false; // Set the cooldown as inactive when the time runs out.
        timer.cancel(); // Cancel the timer.
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed.
    isCooldownActive.value = false; // Reset the state.
    super.onClose(); // Call the onClose method of the base class.
  }

  // Function to format the cooldown time into a readable string.
  String formatCooldownTime(int seconds) {
    if (seconds >= 86400) {
      int days = seconds ~/ 86400; // Calculate days.
      int hours = (seconds % 86400) ~/ 3600; // Calculate remaining hours.
      return '${days}d ${hours}h'; // Return the formatted string with days and hours.
    } else if (seconds >= 3600) {
      int hours = seconds ~/ 3600; // Calculate hours.
      int minutes = (seconds % 3600) ~/ 60; // Calculate remaining minutes.
      return '${hours}h ${minutes}m'; // Return the formatted string with hours and minutes.
    } else if (seconds >= 60) {
      int minutes = seconds ~/ 60; // Calculate minutes.
      int secs = seconds % 60; // Calculate remaining seconds.
      return '${minutes}m ${secs}s'; // Return the formatted string with minutes and seconds.
    } else {
      return '${seconds}s'; // Return the formatted string with just seconds.
    }
  }
}
