import 'dart:developer';

import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/models/crimstone_model.dart';
import 'package:sunflower_tools/modules/shared/models/crop_model.dart';
import 'package:sunflower_tools/modules/shared/models/field_model.dart';
import 'package:sunflower_tools/modules/shared/models/flower_bed_model.dart';
import 'package:sunflower_tools/modules/shared/models/fruit_patch_model.dart';
import 'package:sunflower_tools/modules/shared/models/gold_model.dart';
import 'package:sunflower_tools/modules/shared/models/oil_reserve_model.dart';
import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';
import 'package:sunflower_tools/modules/shared/models/stone_model.dart';
import 'package:sunflower_tools/modules/shared/models/sunstone_model.dart';
import 'package:sunflower_tools/modules/shared/models/tree_model.dart';
import 'package:sunflower_tools/modules/shared/models/iron_model.dart';

class GroupedController extends GetxController {
  List<FieldModel> fields = [];
  List<CropGroup> groupedCrops = [];
  List<TreeGroup> groupedTrees = [];
  List<StoneGroup> groupedStones = [];
  List<IronGroup> groupedIrons = [];
  List<GoldGroup> groupedGolds = [];
  List<CrimstoneGroup> groupedCrimstones = [];
  List<OilReserveGroup> groupedOils = [];
  List<SunstoneGroup> groupedSunstones = [];
  List<FruitPatchGroup> groupedFruitPatches = [];
  List<FlowerBedGroup> groupedFlowerBeds = [];

  // Função genérica para agrupar itens.
  void createGroupedItems<T>({
    required List<T> items,
    required String Function(T) getName,
    required double Function(T) getAmount,
    required int Function(T) getTime,
    required void Function(Map<String, dynamic>, T) updateGroup,
    required List Function(Map<String, dynamic>) convertMapToList,
  }) {
    Map<String, dynamic> itemMap = {};

    for (var item in items) {
      if (getName(item) != 'Unknown') {
        String name = getName(item);
        double amount = getAmount(item);
        int time = getTime(item);

        if (!itemMap.containsKey(name)) {
          itemMap[name] = {
            'name': name,
            'amount': amount,
            'quantityGroup': 1,
            'quantitiesWithValues': [QuantityValue(quantity: 1, value: amount)],
            'time': time,
          };
        } else {
          updateGroup(itemMap[name], item);
        }
      }
    }

    // Converte o mapa de volta para uma lista e atualiza a lista agrupada correspondente.
    List groupedItems = convertMapToList(itemMap);
    if (T == FieldModel) {
      groupedCrops = groupedItems as List<CropGroup>;
    } else if (T == TreeModel) {
      groupedTrees = groupedItems as List<TreeGroup>;
    } else if (T == StoneModel) {
      groupedStones = groupedItems as List<StoneGroup>;
    } else if (T == IronModel) {
      groupedIrons = groupedItems as List<IronGroup>;
    } else if (T == GoldModel) {
      groupedGolds = groupedItems as List<GoldGroup>;
    } else if (T == CrimstoneModel) {
      groupedCrimstones = groupedItems as List<CrimstoneGroup>;
    } else if (T == OilReserveModel) {
      groupedOils = groupedItems as List<OilReserveGroup>;
    } else if (T == SunstoneModel) {
      groupedSunstones = groupedItems as List<SunstoneGroup>;
    } else if (T == FruitPatchModel) {
      log(groupedItems.toString());
      groupedFruitPatches = groupedItems as List<FruitPatchGroup>;
    } else if (T == FlowerBedModel) {
      groupedFlowerBeds = groupedItems as List<FlowerBedGroup>;
    }
  }

  void updateGroup(Map<String, dynamic> group, dynamic item) {
    double amount;
    int time;

    if (item is FieldModel && item.crop != null) {
      amount = item.crop!.amount!;
      time = item.crop!.plantedAt!;

      // Atualiza rewards e fertiliser se existirem.
      var reward = item.crop!.reward;
      var fertiliser = item.crop!.fertiliser;

      if (reward != null) {
        if (group['reward'] == null) {
          group['reward'] = reward;
        } else {
          for (var itemReward in reward.items!) {
            bool itemFound = false;
            for (var groupItem in group['reward'].items!) {
              if (groupItem.name == itemReward.name) {
                groupItem.amount =
                    (groupItem.amount ?? 0) + (itemReward.amount ?? 0);
                itemFound = true;
                break;
              }
            }
            if (!itemFound) {
              group['reward'].items!.add(itemReward);
            }
          }
        }
      }

      if (fertiliser != null) {
        if (group['fertiliser'] == null) {
          group['fertiliser'] = fertiliser;
        } else if (group['fertiliser'].name == fertiliser.name) {
          group['fertiliser'].quantity =
              (group['fertiliser'].quantity ?? 0) + 1;
        }
      }
    } else if (item is TreeModel && item.wood != null) {
      amount = item.wood!.amount!;
      time = item.wood!.choppedAt!;
    } else if (item is StoneModel && item.stone != null) {
      amount = item.stone!.amount!;
      time = item.stone!.minedAt!;
    } else if (item is IronModel && item.stone != null) {
      amount = item.stone!.amount!;
      time = item.stone!.minedAt!;
    } else if (item is GoldModel && item.stone != null) {
      amount = item.stone!.amount!;
      time = item.stone!.minedAt!;
    } else if (item is CrimstoneModel && item.stone != null) {
      amount = item.stone!.amount!;
      time = item.stone!.minedAt!;
    } else if (item is SunstoneModel && item.stone != null) {
      amount = item.stone!.amount!;
      time = item.stone!.minedAt!;
    } else if (item is OilReserveModel && item.oil != null) {
      amount = item.oil!.amount!;
      time = item.oil!.drilledAt!;
    } else if (item is FruitPatchModel && item.fruit != null) {
      amount = item.fruit!.amount!;
      time = item.fertiliser != null
          ? item.fruit!.harvestedAt!
          : item.fruit!.plantedAt!;
    } else if (item is FlowerBedModel && item.flower != null) {
      amount = item.flower!.amount!;
      time = item.flower!.plantedAt!;
    } else {
      throw Exception(
          'Tipo de item desconhecido ou item não possui dados necessários.');
    }

    // Atualiza a quantidade e o grupo de quantidade.
    group['amount'] += amount;
    group['quantityGroup'] += 1;

    // Agrupa quantidades e valores.
    bool found = false;
    for (var qv in group['quantitiesWithValues']) {
      if (qv.value == amount) {
        qv.quantity += 1;
        found = true;
        break;
      }
    }
    if (!found) {
      group['quantitiesWithValues']
          .add(QuantityValue(quantity: 1, value: amount));
    }

    // Atualiza o tempo se o item atual foi processado mais tarde.
    if (time > group['time']) {
      group['time'] = time;
    }
  }

  void updateFieldsFromJson(Map<String, dynamic> jsonMap) {
    fields = jsonMap.entries
        .map((entry) => FieldModel.fromJson(entry.value))
        .toList();

    createGroupedItems(
      items: fields,
      getName: (field) => field.crop?.name ?? 'Unknown',
      getAmount: (field) => field.crop?.amount ?? 0,
      getTime: (field) => field.crop?.plantedAt ?? 0,
      updateGroup: updateGroup,
      convertMapToList: convertCropsMapToList,
    );
  }

  List<CropGroup> convertCropsMapToList(Map<String, dynamic> cropMap) {
    return cropMap.values.map((crop) {
      return CropGroup(
        name: crop['name'],
        amount: crop['amount'],
        quantityGroup: crop['quantityGroup'],
        quantitiesWithValues: crop['quantitiesWithValues'],
        reward: crop['reward'],
        fertiliser: crop['fertiliser'],
        earliestPlantedAt: crop['time'],
      );
    }).toList();
  }

  // Atualização de árvores (trees)
  void updateTreesFromJson(Map<String, dynamic> jsonMap) {
    List<TreeModel> trees = jsonMap.entries
        .map((entry) => TreeModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: trees,
      getName: (_) => 'Tree',
      getAmount: (tree) => tree.wood!.amount!,
      getTime: (tree) => tree.wood!.choppedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertTreesMapToList,
    );
  }

  List<TreeGroup> convertTreesMapToList(Map<String, dynamic> treeMap) {
    return treeMap.values.map((tree) {
      return TreeGroup(
        amount: tree['amount'],
        quantityGroup: tree['quantityGroup'],
        quantitiesWithValues: tree['quantitiesWithValues'],
        earliestChoppedAt: tree['time'],
      );
    }).toList();
  }

  // Atualização de pedras (stones)
  void updateStonesFromJson(Map<String, dynamic> jsonMap) {
    List<StoneModel> stones = jsonMap.entries
        .map((entry) => StoneModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: stones,
      getName: (_) => 'Stone',
      getAmount: (stone) => stone.stone!.amount!,
      getTime: (stone) => stone.stone!.minedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertStonesMapToList,
    );
  }

  List<StoneGroup> convertStonesMapToList(Map<String, dynamic> stoneMap) {
    return stoneMap.values.map((stone) {
      return StoneGroup(
        amount: stone['amount'],
        quantityGroup: stone['quantityGroup'],
        quantitiesWithValues: stone['quantitiesWithValues'],
        earliestMinedAt: stone['time'],
      );
    }).toList();
  }

  // Atualização de ferro (iron)
  void updateIronsFromJson(Map<String, dynamic> jsonMap) {
    List<IronModel> irons = jsonMap.entries
        .map((entry) => IronModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: irons,
      getName: (_) => 'Iron',
      getAmount: (iron) => iron.stone!.amount!,
      getTime: (iron) => iron.stone!.minedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertIronsMapToList,
    );
  }

  List<IronGroup> convertIronsMapToList(Map<String, dynamic> ironMap) {
    return ironMap.values.map((iron) {
      return IronGroup(
        amount: iron['amount'],
        quantityGroup: iron['quantityGroup'],
        quantitiesWithValues: iron['quantitiesWithValues'],
        earliestMinedAt: iron['time'],
      );
    }).toList();
  }

  // Função para atualizar ouro a partir de um mapa JSON.
  void updateGoldsFromJson(Map<String, dynamic> jsonMap) {
    List<GoldModel> golds = jsonMap.entries
        .map((entry) => GoldModel.fromJson(entry.value))
        .toList();

    createGroupedItems(
      items: golds,
      getName: (_) => 'Gold',
      getAmount: (gold) => gold.stone!.amount!,
      getTime: (gold) => gold.stone!.minedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertGoldsMapToList,
    );
  }

  List<GoldGroup> convertGoldsMapToList(Map<String, dynamic> goldMap) {
    return goldMap.values.map((gold) {
      return GoldGroup(
        amount: gold['amount'],
        quantityGroup: gold['quantityGroup'],
        quantitiesWithValues: gold['quantitiesWithValues'],
        earliestMinedAt: gold['time'],
      );
    }).toList();
  }

  // Função para atualizar crimstones a partir de um mapa JSON.
  void updateCrimstonesFromJson(Map<String, dynamic> jsonMap) {
    List<CrimstoneModel> crimstones = jsonMap.entries
        .map((entry) => CrimstoneModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: crimstones,
      getName: (_) => 'Crimstone',
      getAmount: (crimstone) => crimstone.stone!.amount!,
      getTime: (crimstone) => crimstone.stone!.minedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertCrimstonesMapToList,
    );
  }

  List<CrimstoneGroup> convertCrimstonesMapToList(
      Map<String, dynamic> crimstoneMap) {
    return crimstoneMap.values.map((crimstone) {
      return CrimstoneGroup(
        amount: crimstone['amount'],
        quantityGroup: crimstone['quantityGroup'],
        quantitiesWithValues: crimstone['quantitiesWithValues'],
        earliestMinedAt: crimstone['time'],
      );
    }).toList();
  }

  // Função para atualizar oilReserves a partir de um mapa JSON.
  void updateOilReservesFromJson(Map<String, dynamic> jsonMap) {
    List<OilReserveModel> oilReserves = jsonMap.entries
        .map((entry) => OilReserveModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: oilReserves,
      getName: (_) => 'OilReserve',
      getAmount: (oilReserve) => oilReserve.oil!.amount!,
      getTime: (oilReserve) => oilReserve.oil!.drilledAt!,
      updateGroup: updateGroup,
      convertMapToList: convertOilReservesMapToList,
    );
  }

  List<OilReserveGroup> convertOilReservesMapToList(
      Map<String, dynamic> oilReserveMap) {
    return oilReserveMap.values.map((oilReserve) {
      return OilReserveGroup(
        amount: oilReserve['amount'],
        quantityGroup: oilReserve['quantityGroup'],
        quantitiesWithValues: oilReserve['quantitiesWithValues'],
        earliestDrilledAt: oilReserve['time'],
      );
    }).toList();
  }

  // Função para atualizar sunstones a partir de um mapa JSON.
  void updateSunstonesFromJson(Map<String, dynamic> jsonMap) {
    List<SunstoneModel> sunstones = jsonMap.entries
        .map((entry) => SunstoneModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: sunstones,
      getName: (_) => 'Sunstone',
      getAmount: (sunstone) => sunstone.stone!.amount!,
      getTime: (sunstone) => sunstone.stone!.minedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertSunstonesMapToList,
    );
  }

  List<SunstoneGroup> convertSunstonesMapToList(
      Map<String, dynamic> sunstoneMap) {
    return sunstoneMap.values.map((sunstone) {
      return SunstoneGroup(
        amount: sunstone['amount'],
        quantityGroup: sunstone['quantityGroup'],
        quantitiesWithValues: sunstone['quantitiesWithValues'],
        earliestMinedAt: sunstone['time'],
      );
    }).toList();
  }

  // Função para atualizar fruitPatches a partir de um mapa JSON.
  void updateFruitPatchesFromJson(Map<String, dynamic> jsonMap) {
    List<FruitPatchModel> fruitPatches = jsonMap.entries
        .map((entry) => FruitPatchModel.fromJson(entry.value))
        .toList();
    createGroupedItems(
      items: fruitPatches,
      getName: (fruitPatch) => fruitPatch.fruit!.name!,
      getAmount: (fruitPatch) => fruitPatch.fruit!.amount!,
      getTime: (fruitPatch) => fruitPatch.fertiliser != null
          ? fruitPatch.fruit!.harvestedAt!
          : fruitPatch.fruit!.plantedAt!,
      updateGroup: updateGroup,
      convertMapToList: convertFruitPatchesMapToList,
    );
  }

  List<FruitPatchGroup> convertFruitPatchesMapToList(
      Map<String, dynamic> fruitPatchMap) {
    return fruitPatchMap.values.map((fruitPatch) {
      return FruitPatchGroup(
        name: fruitPatch['name'],
        amount: fruitPatch['amount'],
        quantityGroup: fruitPatch['quantityGroup'],
        quantitiesWithValues: fruitPatch['quantitiesWithValues'],
        earliestHarvestedAt: fruitPatch['time'],
      );
    }).toList();
  }

  void updateFlowerBedsFromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap.containsKey('flowerBeds')) {
      Map<String, dynamic> flowerBedsMap = jsonMap['flowerBeds'];
      List<FlowerBedModel> flowerBeds = flowerBedsMap.entries
          .map((entry) => FlowerBedModel.fromJson(entry.value))
          .where((flowerBed) =>
              flowerBed.flower != null) // Filtra os valores nulos.
          .toList();
      createGroupedItems(
        items: flowerBeds,
        getName: (flowerBed) => flowerBed.flower?.name ?? 'Unknown',
        getAmount: (flowerBed) => flowerBed.flower?.amount ?? 0,
        getTime: (flowerBed) => flowerBed.flower?.plantedAt ?? 0,
        updateGroup: updateGroup,
        convertMapToList: convertFlowerBedsMapToList,
      );
    } else {
      log('Chave flowerBeds não encontrada no JSON.');
    }
  }

  List<FlowerBedGroup> convertFlowerBedsMapToList(
      Map<String, dynamic> flowerBedMap) {
    return flowerBedMap.values.map((flowerBed) {
      return FlowerBedGroup(
        name: flowerBed['name'],
        amount: flowerBed['amount'],
        quantityGroup: flowerBed['quantityGroup'],
        quantitiesWithValues: flowerBed['quantitiesWithValues'],
        earliestPlantedAt: flowerBed['time'],
      );
    }).toList();
  }
}
