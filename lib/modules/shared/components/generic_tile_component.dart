import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:get/get.dart'; // Imports the GetX library for state management.
import 'package:sunflower_tools/modules/shared/components/expansion_tile_component.dart'; // Imports the ExpansionTile component.
import 'package:sunflower_tools/modules/shared/components/text_component.dart'; // Imports the TextComponent.
import 'package:sunflower_tools/modules/shared/constants/image_way_constants.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart'; // Imports general constants.
import 'package:sunflower_tools/modules/shared/config/cooldown_controller.dart'; // Imports the CooldownController.
import 'package:sunflower_tools/modules/shared/config/timer.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart'; // Imports the Theme.

class GenericTileComponent<T> extends StatelessWidget {
  final T item; // Generic item to be displayed.
  final String title; // Title of the item.
  final String imageName; // URL of the image.
  final int earliestTime; // Earliest time for cooldown calculation.
  final int Function(String) getGrowTime; // Function to get grow time.
  final List<Map<String, dynamic>> rewards; // List of rewards.
  final List<Map<String, dynamic>> quantitiesWithValues;
  final double amount; // List of quantities with values.
  final String plotsImage;

  const GenericTileComponent({
    super.key,
    required this.item,
    required this.title,
    required this.imageName,
    required this.earliestTime,
    required this.getGrowTime,
    required this.rewards,
    required this.quantitiesWithValues,
    required this.amount,
    required this.plotsImage,
  }); // Constructor with required parameters.

  @override
  Widget build(BuildContext context) {
    // Creates a new cooldown controller for this component with a unique tag.
    final CooldownController cooldownController =
        Get.put(CooldownController(), tag: title);

    // Calculate the cooldown based on formattedItemData.
    String formattedData = formattedItemData(
        earliestTime, getGrowTime(title.toLowerCase()), 'America/Sao_Paulo',
        returnDifference: true);
    int cooldown = int.parse(formattedData);

    // Start the cooldown if it's not active.
    if (!cooldownController.isCooldownActive.value) {
      cooldownController.startCooldown(cooldown);
    }

    return Obx(
      () => ExpansionTileComponent(
        imageName: imageName,
        subTittleAsset: 'assets/images/png/ui/basket.png',
        title: title,
        doubleTittle: cooldownController.formatCooldownTime(
                    cooldownController.cooldownTime.value) !=
                '0s'
            ? cooldownController
                .formatCooldownTime(cooldownController.cooldownTime.value)
            : 'Ready',
        doubleTittleAsset: cooldownController.formatCooldownTime(
                    cooldownController.cooldownTime.value) !=
                '0s'
            ? 'assets/images/png/ui/sandtimer.png'
            : 'assets/images/png/ui/confirm.png',
        subtittleTile: ' ${amount.toStringAsFixed(2)}',
        enabled: true,
        child: Column(
          children: [
            if (rewards.isNotEmpty)
              Row(
                children: [
                  // Check the reward type and display the correct image
                  rewards.first['name'] == 'Seed'
                      ? Image.asset(
                          getImageWay('seeds'),
                          width: kIconsSizeUltraSmall,
                          height: kIconsSizeUltraSmall,
                          fit: BoxFit.fill,
                        )
                      : rewards.first['name'] == 'Coin'
                          ? Image.asset(
                              'assets/images/webp/coins.webp',
                              width: kIconsSizeUltraSmall,
                              height: kIconsSizeUltraSmall,
                              fit: BoxFit.fill,
                            )
                          : Container(), // Empty container if reward type is neither Seed nor Coin
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rewards
                          .map(
                            (item) => Row(
                              children: [
                                item['name'].contains('Seed')
                                    ? Image.asset(
                                        getImageWay('seeds'),
                                        width: kIconsSizeUltraSmall,
                                        height: kIconsSizeUltraSmall,
                                        fit: BoxFit.fill,
                                      )
                                    : item['name'].contains('Coin')
                                        ? Image.asset(
                                            'assets/images/webp/coins.webp',
                                            width: kIconsSizeUltraSmall,
                                            height: kIconsSizeUltraSmall,
                                            fit: BoxFit.fill,
                                          )
                                        : Container(), // Empty container if reward type is neither Seed nor Coin
                                const SizedBox(width: 10),
                                TextComponent(
                                  text: '${item['name']}: ${item['amount']}',
                                  size: kFontSizeSmall,
                                  color: ThemeColor.blackColor,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            // Ensuring that quantities with values are always displayed.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: quantitiesWithValues
                  .map(
                    (item) => Row(
                      children: [
                        Image.asset(
                          getImageWay(plotsImage), // Placeholder image URL
                          height: kIconsSizeUltraSmall,
                          width: kIconsSizeUltraSmall,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                            width: 10), // Space between image and text
                        TextComponent(
                          text:
                              '${item['quantity']} x ${item['value'].toStringAsFixed(2)}',
                          size: kFontSizeSmall,
                          color: ThemeColor.blackColor,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
