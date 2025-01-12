import 'package:flutter/material.dart';
import 'package:sunflower_tools/modules/shared/components/icon_component.dart';
import 'package:sunflower_tools/modules/shared/components/text_component.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final IconData? icon;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;

  const AppBarComponent({
    super.key,
    required this.name,
    this.icon,
    this.automaticallyImplyLeading = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: ThemeColor.whiteColor,
      foregroundColor: ThemeColor.primaryColor,
      surfaceTintColor: ThemeColor.whiteColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: icon == null
            ? [
                TextComponent(
                  text: name,
                  size: kFontSizeVeryBig,
                ),
              ]
            : [
                IconComponent(
                  icon: icon,
                  size: kIconSizeStandart,
                  color: ThemeColor.primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                TextComponent(
                  text: name,
                  size: kFontSizeVeryBig,
                ),
              ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
