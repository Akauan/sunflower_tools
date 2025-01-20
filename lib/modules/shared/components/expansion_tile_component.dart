import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/components/text_component.dart';
import 'package:sunflower_tools/modules/shared/constants/image_way_constants.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/controllers/prices_controller.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

// ignore: must_be_immutable
class ExpansionTileComponent extends StatelessWidget {
  final String title;
  final Widget child;
  final String? subtittleTile;
  final bool enabled;
  final String? subsubtittle;
  final String? imageName;
  final String? subTittleAsset;
  final String? subsubTittleAsset;
  final String? doubleTittle;
  final String? doubleTittleAsset;
  final String? doubleSubTittle;
  final String? doubleSubTittleAsset;

  const ExpansionTileComponent({
    super.key,
    required this.title,
    required this.child,
    this.subtittleTile,
    this.enabled = false,
    this.subsubtittle,
    this.imageName,
    this.subsubTittleAsset,
    this.subTittleAsset,
    this.doubleTittle,
    this.doubleTittleAsset,
    this.doubleSubTittle,
    this.doubleSubTittleAsset,
  });

  @override
  Widget build(BuildContext context) {
    final PricesController pricesController = Get.find<PricesController>();

    return subtittleTile == null
        ? ExpansionTile(
            enabled: enabled,
            trailing: enabled ? null : const SizedBox.shrink(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Conditionally load the image before the title if imageWidget is not null
                          if (imageName != null)
                            Image.asset(
                              getImageWay(imageName!),
                              width: kIconsSizeUltraSmall,
                              height: kIconsSizeUltraSmall,
                              fit: BoxFit.fill,
                            ),
                          if (imageName != null)
                            const SizedBox(
                                width:
                                    10), // Add spacing between the image and the title
                          TextComponent(
                            text: title,
                            overflow: TextOverflow.ellipsis,
                            size: kFontSizeStandard,
                            maxFontSize: kFontSizeStandard,
                            minFontSize: kFontSizeSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: ThemeColor.whiteColor,
            collapsedBackgroundColor: ThemeColor.whiteColor,
            tilePadding: const EdgeInsets.only(
              top: kPaddingVerySmall,
              bottom: kPaddingVerySmall,
              left: kPaddingStandard,
              right: kPaddingStandard,
            ),
            collapsedIconColor: ThemeColor.greyColor,
            iconColor: ThemeColor.greyColor,
            shape: Border(
              bottom: BorderSide(
                  color: ThemeColor.whiteColor.withOpacity(0.7), width: 1),
            ),
            collapsedShape: Border(
              bottom: BorderSide(
                  color: ThemeColor.greyColor.withOpacity(0.7), width: 1),
            ),
            expansionAnimationStyle: AnimationStyle(
              curve: Easing.linear,
              duration: Durations.medium3,
            ),
            children: [
              SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kRadiusMedium),
                    ),
                    border: Border.all(color: ThemeColor.primaryColor),
                    color: ThemeColor.primaryColor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kPaddingStandard),
                    child: child,
                  ),
                ),
              )
            ],
          )
        : ExpansionTile(
            enabled: enabled,
            trailing: enabled ? null : const SizedBox.shrink(),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (subTittleAsset != null)
                          Image.asset(
                            subTittleAsset!,
                            width: kIconsSizeUltraSmall,
                            height: kIconsSizeUltraSmall,
                            fit: BoxFit.fill,
                          ),
                        if (subtittleTile != null)
                          const SizedBox(
                            width: 10,
                          ),
                        TextComponent(
                          text: subtittleTile!,
                          overflow: TextOverflow.ellipsis,
                          size: kFontSizeSmall,
                          maxFontSize: kFontSizeSmall,
                          minFontSize: kFontSizeSmall,
                          color: ThemeColor.greyColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (doubleSubTittle != null)
                          TextComponent(
                            text: pricesController.getP2pPrice(
                                doubleSubTittle!, double.parse(subtittleTile!)),
                            overflow: TextOverflow.ellipsis,
                            size: kFontSizeSmall,
                            maxFontSize: kFontSizeSmall,
                            minFontSize: kFontSizeSmall,
                            color: ThemeColor.greyColor,
                          ),
                        if (doubleSubTittle != null)
                          const SizedBox(
                            width: 10,
                          ),
                        if (doubleSubTittle != null)
                          Image.asset(
                            getImageWay('sfl'),
                            width: kIconsSizeUltraSmall,
                            height: kIconsSizeUltraSmall,
                            fit: BoxFit.fill,
                          ),
                      ],
                    ),
                  ],
                ),
                subsubtittle != null
                    ? Row(
                        children: [
                          if (subsubTittleAsset != null)
                            Image.asset(
                              subsubTittleAsset!,
                              width: kIconsSizeUltraSmall,
                              height: kIconsSizeUltraSmall,
                              fit: BoxFit.fill,
                            ),
                          if (subsubTittleAsset != null)
                            const SizedBox(
                              width: 10,
                            ),
                          TextComponent(
                            text: subsubtittle!,
                            overflow: TextOverflow.ellipsis,
                            size: kFontSizeSmall,
                            maxFontSize: kFontSizeSmall,
                            minFontSize: kFontSizeSmall,
                            color: ThemeColor.greyColor,
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Conditionally load the image before the title if imageWidget is not null
                    if (imageName != null)
                      Image.asset(
                        getImageWay(imageName!),
                        width: kIconsSizeUltraSmall,
                        height: kIconsSizeUltraSmall,
                        fit: BoxFit.fill,
                      ),
                    if (imageName != null)
                      const SizedBox(
                          width:
                              10), // Add spacing between the image and the title
                    TextComponent(
                      text: title,
                      overflow: TextOverflow.ellipsis,
                      size: kFontSizeSmall,
                      maxFontSize: kFontSizeStandard,
                      minFontSize: kFontSizeSmall,
                    ),
                  ],
                ),
                if (doubleTittle != null)
                  Row(
                    children: [
                      TextComponent(
                        text: doubleTittle!,
                        overflow: TextOverflow.ellipsis,
                        size: kFontSizeSmall,
                        maxFontSize: kFontSizeStandard,
                        minFontSize: kFontSizeSmall,
                        color: ThemeColor.greyColor,
                      ),
                      if (doubleTittleAsset != null) const SizedBox(width: 10),
                      // Conditionally load the image before the title if imageWidget is not null
                      if (doubleTittleAsset != null)
                        Image.asset(
                          doubleTittleAsset!,
                          width: kIconsSizeUltraSmall,
                          height: kIconsSizeUltraSmall,
                          fit: BoxFit.fill,
                        ),
                      // Add spacing between the image and the title
                    ],
                  ),
              ],
            ),
            backgroundColor: ThemeColor.whiteColor,
            collapsedBackgroundColor: ThemeColor.whiteColor,
            tilePadding: const EdgeInsets.only(
              top: kPaddingVerySmall,
              bottom: kPaddingVerySmall,
              left: kPaddingStandard,
              right: kPaddingStandard,
            ),
            collapsedIconColor: ThemeColor.greyColor,
            iconColor: ThemeColor.greyColor,
            shape: Border(
              bottom: BorderSide(
                  color: ThemeColor.whiteColor.withOpacity(0.7), width: 1),
            ),
            collapsedShape: Border(
              bottom: BorderSide(
                  color: ThemeColor.greyColor.withOpacity(0.7), width: 1),
            ),
            expansionAnimationStyle: AnimationStyle(
              curve: Easing.linear,
              duration: Durations.medium3,
            ),
            children: [
              SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kRadiusMedium),
                    ),
                    border: Border.all(color: ThemeColor.primaryColor),
                    color: ThemeColor.primaryColor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kPaddingStandard),
                    child: child,
                  ),
                ),
              )
            ],
          );
  }
}
