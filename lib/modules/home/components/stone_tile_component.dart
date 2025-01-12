import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart';
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/stone_model.dart'; // Imports the GenericTileComponent.
// Imports the Theme.

class StoneTileComponent extends StatelessWidget {
  final StoneGroup stone; // Stone to be displayed.

  const StoneTileComponent(
      {super.key,
      required this.stone}); // Constructor with a required stone parameter.

  @override
  Widget build(BuildContext context) {
    return GenericTileComponent(
      item: stone,
      title: 'Stone',
      imageName: 'stone',
      earliestTime: stone.earliestMinedAt!,
      getGrowTime: (name) => getCropGrowTime('stone'),
      rewards: const [], // Assuming no specific rewards for stones
      quantitiesWithValues: stone.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: stone.amount,
      plotsImage: 'stone_plot',
    );
  }
}
