import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/models/fruit_patch_model.dart';
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';

class FruitPatchTileComponent extends StatelessWidget {
  final FruitPatchGroup fruitPatch; // Fruit patch to be displayed.

  const FruitPatchTileComponent(
      {super.key,
      required this.fruitPatch}); // Constructor with a required fruitPatch parameter.

  @override
  Widget build(BuildContext context) {
    // Assuming a static image for fruit patches.
    return GenericTileComponent(
      item: fruitPatch,
      title: fruitPatch.name,
      imageName: fruitPatch.name,
      earliestTime: fruitPatch.earliestHarvestedAt,
      getGrowTime: (name) => getCropGrowTime(fruitPatch.name.toLowerCase()),
      rewards: const [], // Assuming no specific rewards for fruit patches
      quantitiesWithValues: fruitPatch.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: fruitPatch.amount,
      plotsImage: 'fruit_plot',
    );
  }
}
