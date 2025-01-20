import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/iron_model.dart';

class IronTileComponent extends StatelessWidget {
  final IronGroup iron; // Iron to be displayed.

  const IronTileComponent(
      {super.key,
      required this.iron}); // Constructor with a required iron parameter.

  @override
  Widget build(BuildContext context) {
// Assuming a static image for iron.

    return GenericTileComponent(
      item: iron,
      title: 'Iron',
      doubleSubTittle: 'Iron',
      imageName: 'iron',
      earliestTime: iron.earliestMinedAt!,
      getGrowTime: (name) => getCropGrowTime('iron'),
      rewards: const [], // Assuming no specific rewards for iron
      quantitiesWithValues: iron.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: iron.amount,
      plotsImage: 'iron_plot',
    );
  }
}
