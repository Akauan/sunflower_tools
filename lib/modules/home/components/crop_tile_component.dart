import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/crop_model.dart';

class CropTileComponent extends StatelessWidget {
  final CropGroup field; // Field to be displayed.

  const CropTileComponent(
      {super.key,
      required this.field}); // Constructor with a required field parameter.

  @override
  Widget build(BuildContext context) {
    return GenericTileComponent(
      item: field,
      title: field.name,
      doubleSubTittle: field.name,
      amount: field.amount,
      imageName: field.name,
      earliestTime: field.earliestPlantedAt!,
      getGrowTime: getCropGrowTime,
      rewards: field.reward?.items
              ?.map((item) => {'name': item.name, 'amount': item.amount})
              .toList() ??
          [],
      quantitiesWithValues: field.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      plotsImage: 'seed_plot',
    );
  }
}
