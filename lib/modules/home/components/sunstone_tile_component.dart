import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/sunstone_model.dart';

class SunstoneTileComponent extends StatelessWidget {
  final SunstoneGroup sunstone; // Iron to be displayed.

  const SunstoneTileComponent(
      {super.key,
      required this.sunstone}); // Constructor with a required sunstone parameter.

  @override
  Widget build(BuildContext context) {
// Assuming a static image for sunstone.

    return GenericTileComponent(
      item: sunstone,
      title: 'Sunstone',
      imageName: 'sunstone',
      earliestTime: sunstone.earliestMinedAt,
      getGrowTime: (name) => getCropGrowTime('sunstone'),
      rewards: const [], // Assuming no specific rewards for sunstone
      quantitiesWithValues: sunstone.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: sunstone.amount,
      plotsImage: 'sunstone_plot',
    );
  }
}
