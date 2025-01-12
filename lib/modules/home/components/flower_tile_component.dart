import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/flower_bed_model.dart';
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.

class FlowerBedTileComponent extends StatelessWidget {
  final FlowerBedGroup flowerBed; // Flower bed to be displayed.

  const FlowerBedTileComponent(
      {super.key,
      required this.flowerBed}); // Constructor with a required flowerBed parameter.

  @override
  Widget build(BuildContext context) {
    // Assuming a static image for flower beds.

    return GenericTileComponent(
      item: flowerBed,
      title: flowerBed.name.replaceAll('Flower', ''),
      imageName: flowerBed.name,
      earliestTime: flowerBed.earliestPlantedAt,
      getGrowTime: (name) => getCropGrowTime(flowerBed.name.toLowerCase()),
      rewards: const [], // Assuming no specific rewards for flower beds.
      quantitiesWithValues: flowerBed.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      amount: flowerBed.amount,
      plotsImage: flowerBed.name,
    );
  }
}
