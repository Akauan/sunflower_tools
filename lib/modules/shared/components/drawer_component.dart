import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/login/controllers/login_controller.dart';
import 'package:sunflower_tools/modules/shared/components/icon_component.dart';
import 'package:sunflower_tools/modules/shared/components/text_component.dart';
import 'package:sunflower_tools/modules/shared/config/notification_service.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/controllers/farm_controller.dart';
import 'package:sunflower_tools/modules/shared/config/local_secure_data.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';
import 'package:workmanager/workmanager.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final FarmController farmController = Get.find<FarmController>();
    final LoginController loginController = Get.find<LoginController>();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   radius: kIconSizeSemiMedium,
              //   backgroundImage: AssetImage('assets/images/png/aluno.png'),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingSmall),
                    child: TextComponent(
                      text: farmController.farmData['username'] ?? 'Username',
                      size: kFontSizeStandard,
                      color: ThemeColor.blackColor,
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: kPaddingSmall),
                  //   child: TextComponent(
                  //     text: farmController.farmData['faction']['name'] ?? '',
                  //     size: kFontSizeStandard,
                  //     color: ThemeColor.blackColor,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // )
                ],
              )
            ],
          )),

          // _listTile(
          //   icon: Icons.person,
          //   text: 'Autores',
          //   onPressed: () {
          //     /// Close Navigation drawer before
          //     Navigator.pop(context);
          //     // Verify the route
          //     if (ModalRoute.of(context)!.settings.name == '/homePage') {
          //       Navigator.pushNamed(context, '/authorsListPage');
          //     } else {
          //       if (ModalRoute.of(context)!.settings.name ==
          //           '/bookDetailPage') {
          //         Navigator.pop(context);
          //       }
          //       Navigator.popAndPushNamed(context, '/authorsListPage');
          //     }
          //   },
          // ),

          _listTile(
              icon: Icons.logout,
              text: 'Sair',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/loginPage');
                NotificationService().cancelAllNotifications();
                Workmanager().cancelAll();
                loginController.clearVariables();
                LocalSecureData.clearDatas();
              })
        ],
      ),
    );
  }

  ListTile _listTile(
      {required IconData icon,
      required String text,
      required Function onPressed}) {
    return ListTile(
      leading: IconComponent(
        icon: icon,
        color: ThemeColor.primaryColor,
        size: kIconSizeSmall,
      ),
      title: TextComponent(
        text: text,
        size: kFontSizeSmall,
        color: ThemeColor.blackColor,
        fontWeight: FontWeight.normal,
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}
