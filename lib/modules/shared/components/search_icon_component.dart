import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/notification_service.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class SearchIconComponent extends StatelessWidget {
  final RxBool showSearch;
  final Function clearList;
  final bool? enabled;

  const SearchIconComponent({
    super.key,
    required this.showSearch,
    required this.clearList,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kPaddingSmall),
      child: IconButton(
        onPressed: enabled!
            ? () {
                // NotificationService.showInstantNotification('title', 'body');
                // DateTime Teste = DateTime.now().add(Duration(seconds: 5));
                NotificationService notificationService = NotificationService();
                notificationService.showActiveNotifications(context);
                // make showSearch true or false
                if (showSearch.value == true) {
                  clearList();
                }
                showSearch.toggle();
              }
            : null,
        icon: Obx(
          () => SizedBox(
            height: 35,
            width: 35,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: showSearch.value
                          ? ThemeColor.buttonCancelColor
                          : ThemeColor.primaryColor,
                      width: 2),
                  left: BorderSide(
                      color: showSearch.value
                          ? ThemeColor.buttonCancelColor
                          : ThemeColor.primaryColor,
                      width: 2),
                  right: BorderSide(
                      color: showSearch.value
                          ? ThemeColor.buttonCancelColor
                          : ThemeColor.primaryColor,
                      width: 2),
                  top: BorderSide(
                      color: showSearch.value
                          ? ThemeColor.buttonCancelColor
                          : ThemeColor.primaryColor,
                      width: 2),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(kRadiusExtremelyBig),
                ),
              ),
              child: Image.asset(
                showSearch.value
                    ? 'assets/images/png/ui/cancel.png'
                    : 'assets/images/png/ui/search.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
