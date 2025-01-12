import 'package:flutter/material.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class ContainerComponent extends StatelessWidget {
  final BoxConstraints constraints;
  final Widget child;
  final EdgeInsets? padding;

  const ContainerComponent({
    super.key,
    required this.constraints,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(kRadiusVeryBig),
        topRight: Radius.circular(kRadiusVeryBig),
      ),
      child: SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kRadiusVeryBig),
              topRight: Radius.circular(kRadiusVeryBig),
            ),
            color: ThemeColor.primaryColor.withOpacity(0.1),
            boxShadow: const [
              BoxShadow(
                color: ThemeColor.blackColor,
                blurRadius: 1,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: ThemeColor.whiteColor,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(0),
            child: child,
          ),
        ),
      ),
    );
  }
}
