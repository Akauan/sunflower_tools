import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/gold_model.dart';

class GoldTileComponent extends StatelessWidget {
  final GoldGroup gold; // Iron to be displayed.

  const GoldTileComponent(
      {super.key,
      required this.gold}); // Constructor with a required gold parameter.

  @override
  Widget build(BuildContext context) {
// Assuming a static image for gold.

    return GenericTileComponent(
      item: gold,
      title: 'Gold',
      doubleSubTittle: 'Gold',
      imageName: 'gold',
      earliestTime: gold.earliestMinedAt,
      getGrowTime: (name) => getCropGrowTime('gold'),
      rewards: const [], // Assuming no specific rewards for gold
      quantitiesWithValues: gold.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: gold.amount,
      plotsImage: 'gold_plot',
    );
  }
}
