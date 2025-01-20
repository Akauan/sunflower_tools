// import 'package:bibli_if/modules/book/controllers/book_controller.dart';

import 'package:get/get.dart';
import 'package:sunflower_tools/modules/home/controllers/home_controller.dart';
import 'package:sunflower_tools/modules/login/controllers/login_controller.dart';
import 'package:sunflower_tools/modules/shared/config/cooldown_controller.dart';
import 'package:sunflower_tools/modules/shared/controllers/exchange_controller.dart';
import 'package:sunflower_tools/modules/shared/controllers/farm_controller.dart';
import 'package:sunflower_tools/modules/shared/controllers/grouped_controller.dart';
import 'package:sunflower_tools/modules/shared/controllers/prices_controller.dart';

class ControllersInitializedConfig {
  // Instantiating the controllers.
  ControllersInitializedConfig() {
    // Controller LoginController.
    Get.lazyPut(() => FarmController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CooldownController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => GroupedController());
    Get.lazyPut(() => ExchangeController());
    Get.lazyPut(() => PricesController());
  }
}
