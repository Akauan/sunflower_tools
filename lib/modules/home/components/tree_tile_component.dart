import 'package:flutter/material.dart'; // Imports the Flutter library.
import 'package:sunflower_tools/modules/shared/components/generic_tile_component.dart'; // Imports the GenericTileComponent.
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
import 'package:sunflower_tools/modules/shared/models/tree_model.dart';
// Imports the Theme.

class TreeTileComponent extends StatelessWidget {
  final TreeGroup tree; // Tree to be displayed.

  const TreeTileComponent(
      {super.key,
      required this.tree}); // Constructor with a required tree parameter.

  @override
  Widget build(BuildContext context) {
    return GenericTileComponent(
      item: tree,
      amount: tree.amount,
      title: 'Tree',
      imageName: 'wood',
      earliestTime: tree.earliestChoppedAt!,
      getGrowTime: (name) => getCropGrowTime('tree'),
      rewards: const [], // Assuming no specific rewards for trees
      quantitiesWithValues: tree.quantitiesWithValues
          .map((qv) => {'quantity': qv.quantity, 'value': qv.value})
          .toList(),
      plotsImage: 'tree_plot',
    );
  }
}
