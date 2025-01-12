import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/models/crimstone_model.dart';
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';

class CrimstoneTileComponent extends StatelessWidget {
  final CrimstoneGroup crimstone; // Iron to be displayed.

  const CrimstoneTileComponent(
      {super.key,
      required this.crimstone}); // Constructor with a required crimstone parameter.

  @override
  Widget build(BuildContext context) {
// Assuming a static image for crimstone.

    return GenericTileComponent(
      item: crimstone,
      title: 'Crimstone',
      imageName: 'crimstone',
      earliestTime: crimstone.earliestMinedAt,
      getGrowTime: (name) => getCropGrowTime('crimstone'),
      rewards: const [], // Assuming no specific rewards for crimstone
      quantitiesWithValues: crimstone.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: crimstone.amount,
      plotsImage: 'crimstone_plot',
    );
  }
}
