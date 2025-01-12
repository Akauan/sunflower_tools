import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/models/oil_reserve_model.dart';
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';

class OilReserveTileComponent extends StatelessWidget {
  final OilReserveGroup oilReserve; // Oil Reserve to be displayed.

  const OilReserveTileComponent(
      {super.key,
      required this.oilReserve}); // Constructor with a required oilReserve parameter.

  @override
  Widget build(BuildContext context) {
    // Assuming a static image for oilReserve.

    return GenericTileComponent(
      item: oilReserve,
      title: 'Oil Reserve',
      imageName: 'oil',
      earliestTime: oilReserve.earliestDrilledAt,
      getGrowTime: (name) => getCropGrowTime('oil'),
      rewards: const [], // Assuming no specific rewards for oilReserve
      quantitiesWithValues: oilReserve.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: oilReserve.amount,
      plotsImage: 'oil_plot',
    );
  }
}
