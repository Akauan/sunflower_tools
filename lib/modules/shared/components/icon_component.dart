import 'package:flutter/material.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class IconComponent extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
  const IconComponent(
      {super.key, required this.icon, this.color, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? ThemeColor.greyColor,
      size: size,
    );
  }
}
