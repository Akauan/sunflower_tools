import 'dart:developer';

import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/cooldown_controller.dart';
import 'package:sunflower_tools/modules/shared/config/locations.dart';
import 'package:sunflower_tools/modules/shared/config/notification_service.dart';
import 'package:sunflower_tools/modules/shared/config/timer.dart';
import 'package:sunflower_tools/modules/shared/constants/time_contatants.dart';
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
import 'package:timezone/timezone.dart' as tz;

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

  RxList<Map<String, dynamic>> inventoryListItems =
      <Map<String, dynamic>>[].obs;

  final CooldownController cooldownController = Get.put(CooldownController());

  void createInventoryListItems() {
    inventoryListItems.clear();

    inventoryListItems.addAll(
      groupedCrops.map((item) => {'type': 'crop', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedTrees.map((item) => {'type': 'tree', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedStones.map((item) => {'type': 'stone', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedIrons.map((item) => {'type': 'iron', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedGolds.map((item) => {'type': 'gold', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedCrimstones.map((item) => {'type': 'crimstone', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedOils.map((item) => {'type': 'oil', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedSunstones.map((item) => {'type': 'sunstone', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedFruitPatches.map((item) => {'type': 'fruit', 'data': item}),
    );
    inventoryListItems.addAll(
      groupedFlowerBeds.map((item) => {'type': 'flower', 'data': item}),
    );
  }

  void createNotification(String name, int earliestTime, growName) {
    if (tz.TZDateTime.now(LocationsConstants.saoPaulo).isBefore(
        addCooldownWithTimezone(earliestTime,
            getCropGrowTime(growName.toLowerCase()), 'America/Sao_Paulo'))) {
      // Chama a função para disparar a notificação quando o cooldown terminar
      NotificationService().showScheduleNotification(
          name,
          "$name Ready!",
          addCooldownWithTimezone(earliestTime,
              getCropGrowTime(growName.toLowerCase()), 'America/Sao_Paulo'),
          name); // Agendando a notificação para o momento em que o cooldown zerar
    }
  }

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
      for (var crop in groupedCrops) {
        createNotification(crop.name, crop.earliestPlantedAt!, crop.name);
      }
    } else if (T == TreeModel) {
      groupedTrees = groupedItems as List<TreeGroup>;
      for (var tree in groupedTrees) {
        createNotification('Tree', tree.earliestChoppedAt!, 'tree');
      }
    } else if (T == StoneModel) {
      groupedStones = groupedItems as List<StoneGroup>;
      for (var stone in groupedStones) {
        createNotification('Stone', stone.earliestMinedAt!, 'stone');
      }
    } else if (T == IronModel) {
      groupedIrons = groupedItems as List<IronGroup>;
      for (var iron in groupedIrons) {
        createNotification('Iron', iron.earliestMinedAt!, 'iron');
      }
    } else if (T == GoldModel) {
      groupedGolds = groupedItems as List<GoldGroup>;
      for (var gold in groupedGolds) {
        createNotification('Gold', gold.earliestMinedAt, 'gold');
      }
    } else if (T == CrimstoneModel) {
      groupedCrimstones = groupedItems as List<CrimstoneGroup>;
      for (var crimstone in groupedCrimstones) {
        createNotification('Crimstone', crimstone.earliestMinedAt, 'crimstone');
      }
    } else if (T == OilReserveModel) {
      groupedOils = groupedItems as List<OilReserveGroup>;
      for (var oil in groupedOils) {
        createNotification('Oil', oil.earliestDrilledAt, 'oil');
      }
    } else if (T == SunstoneModel) {
      groupedSunstones = groupedItems as List<SunstoneGroup>;
      for (var sunstone in groupedSunstones) {
        createNotification('Sunstone', sunstone.earliestMinedAt, 'sunstone');
      }
    } else if (T == FruitPatchModel) {
      groupedFruitPatches = groupedItems as List<FruitPatchGroup>;
      for (var fruit in groupedFruitPatches) {
        createNotification(fruit.name, fruit.earliestHarvestedAt, fruit.name);
      }
    } else if (T == FlowerBedModel) {
      groupedFlowerBeds = groupedItems as List<FlowerBedGroup>;
      for (var flower in groupedFlowerBeds) {
        createNotification(flower.name, flower.earliestPlantedAt, flower.name);
      }
    }
  }

  DateTime getItemTime(Map<String, dynamic> item) {
    // Obtenha o tipo e o tempo específico do item
    if (item['data'] is CropGroup) {
      var crop = item['data'] as CropGroup;
      return addCooldownWithTimezone(
        crop.earliestPlantedAt!,
        getCropGrowTime(crop.name.toLowerCase()),
        'America/Sao_Paulo',
      );
    } else if (item['data'] is TreeGroup) {
      var tree = item['data'] as TreeGroup;
      return addCooldownWithTimezone(
        tree.earliestChoppedAt!,
        getCropGrowTime('tree'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is StoneGroup) {
      var stone = item['data'] as StoneGroup;
      return addCooldownWithTimezone(
        stone.earliestMinedAt!,
        getCropGrowTime('stone'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is IronGroup) {
      var iron = item['data'] as IronGroup;
      return addCooldownWithTimezone(
        iron.earliestMinedAt!,
        getCropGrowTime('iron'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is GoldGroup) {
      var gold = item['data'] as GoldGroup;
      return addCooldownWithTimezone(
        gold.earliestMinedAt,
        getCropGrowTime('gold'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is CrimstoneGroup) {
      var crimstone = item['data'] as CrimstoneGroup;
      return addCooldownWithTimezone(
        crimstone.earliestMinedAt,
        getCropGrowTime('crimstone'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is OilReserveGroup) {
      var oil = item['data'] as OilReserveGroup;
      return addCooldownWithTimezone(
        oil.earliestDrilledAt,
        getCropGrowTime('oil'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is SunstoneGroup) {
      var sunstone = item['data'] as SunstoneGroup;
      return addCooldownWithTimezone(
        sunstone.earliestMinedAt,
        getCropGrowTime('sunstone'), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is FruitPatchGroup) {
      var fruit = item['data'] as FruitPatchGroup;
      return addCooldownWithTimezone(
        fruit.earliestHarvestedAt,
        getCropGrowTime(
            fruit.name.toLowerCase()), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else if (item['data'] is FlowerBedGroup) {
      var flower = item['data'] as FlowerBedGroup;
      return addCooldownWithTimezone(
        flower.earliestPlantedAt,
        getCropGrowTime(
            flower.name.toLowerCase()), // Substitua pela lógica correta
        'America/Sao_Paulo',
      );
    } else {
      throw Exception(
          'Tipo desconhecido'); // Tratamento de erro para tipos desconhecidos
    }
  }

  void createAndSortInventoryList() {
    createInventoryListItems();

    // Ordenando a lista
    inventoryListItems.sort((a, b) {
      DateTime timeA = getItemTime(a);
      DateTime timeB = getItemTime(b);
      DateTime now = DateTime.now();

      // Verifica se o tempo já passou para ambos os itens
      bool isTimeAPast = timeA.isBefore(now);
      bool isTimeBPast = timeB.isBefore(now);

      if (isTimeAPast && !isTimeBPast) {
        // Se o tempo de A já passou e o de B não, coloca A depois
        return 1;
      } else if (!isTimeAPast && isTimeBPast) {
        // Se o tempo de B já passou e o de A não, coloca B depois
        return -1;
      } else {
        // Ambos estão no mesmo grupo (passado ou futuro), ordena normalmente
        return timeA.compareTo(timeB);
      }
    });
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
      time = item.fruit!.harvestedAt != 0
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
    if (time < group['time']) {
      group['time'] = time;
    }
  }

  // Função genérica para atualizar e agrupar itens a partir de um mapa JSON.
  void updateItemsFromJson<T, G>({
    required Map<String, dynamic> jsonMap,
    required T Function(Map<String, dynamic>) fromJson,
    required G Function(Map<String, dynamic>) fromGroupMap,
    required String Function(T) getName,
    required double Function(T) getAmount,
    required int Function(T) getTime,
  }) {
    log(jsonMap.toString());
    List<T> items =
        jsonMap.entries.map((entry) => fromJson(entry.value)).toList();

    createGroupedItems(
      items: items,
      getName: getName,
      getAmount: getAmount,
      getTime: getTime,
      updateGroup: updateGroup,
      convertMapToList: (map) => map.values
          .map((value) => fromGroupMap(value as Map<String, dynamic>))
          .toList(),
    );
  }

  void updateFieldsFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<FieldModel, CropGroup>(
      jsonMap: jsonMap,
      fromJson: FieldModel.fromJson,
      fromGroupMap: (cropMap) => CropGroup(
        name: cropMap['name'],
        amount: cropMap['amount'],
        quantityGroup: cropMap['quantityGroup'],
        quantitiesWithValues: cropMap['quantitiesWithValues'],
        reward: cropMap['reward'],
        fertiliser: cropMap['fertiliser'],
        earliestPlantedAt: cropMap['time'],
      ),
      getName: (field) => field.crop?.name ?? 'Unknown',
      getAmount: (field) => field.crop?.amount ?? 0,
      getTime: (field) => field.crop?.plantedAt ?? 0,
    );
  }

  void updateTreesFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<TreeModel, TreeGroup>(
      jsonMap: jsonMap,
      fromJson: TreeModel.fromJson,
      fromGroupMap: (treeMap) => TreeGroup(
        amount: treeMap['amount'],
        quantityGroup: treeMap['quantityGroup'],
        quantitiesWithValues: treeMap['quantitiesWithValues'],
        reward: treeMap['reward'],
        earliestChoppedAt: treeMap['time'],
      ),
      getName: (_) => 'Tree',
      getAmount: (tree) => tree.wood!.amount!,
      getTime: (tree) => tree.wood!.choppedAt!,
    );
  }

  void updateStonesFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<StoneModel, StoneGroup>(
      jsonMap: jsonMap,
      fromJson: StoneModel.fromJson,
      fromGroupMap: (stoneMap) => StoneGroup(
        amount: stoneMap['amount'],
        quantityGroup: stoneMap['quantityGroup'],
        quantitiesWithValues: stoneMap['quantitiesWithValues'],
        earliestMinedAt: stoneMap['time'],
      ),
      getName: (_) => 'Stone',
      getAmount: (stone) => stone.stone!.amount!,
      getTime: (stone) => stone.stone!.minedAt!,
    );
  }

  void updateIronsFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<IronModel, IronGroup>(
      jsonMap: jsonMap,
      fromJson: IronModel.fromJson,
      fromGroupMap: (ironMap) => IronGroup(
        amount: ironMap['amount'],
        quantityGroup: ironMap['quantityGroup'],
        quantitiesWithValues: ironMap['quantitiesWithValues'],
        earliestMinedAt: ironMap['time'],
      ),
      getName: (_) => 'Iron',
      getAmount: (iron) => iron.stone!.amount!,
      getTime: (iron) => iron.stone!.minedAt!,
    );
  }

  void updateGoldsFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<GoldModel, GoldGroup>(
      jsonMap: jsonMap,
      fromJson: GoldModel.fromJson,
      fromGroupMap: (goldMap) => GoldGroup(
        amount: goldMap['amount'],
        quantityGroup: goldMap['quantityGroup'],
        quantitiesWithValues: goldMap['quantitiesWithValues'],
        earliestMinedAt: goldMap['time'],
      ),
      getName: (_) => 'Gold',
      getAmount: (gold) => gold.stone!.amount!,
      getTime: (gold) => gold.stone!.minedAt!,
    );
  }

  void updateCrimstonesFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<CrimstoneModel, CrimstoneGroup>(
      jsonMap: jsonMap,
      fromJson: CrimstoneModel.fromJson,
      fromGroupMap: (crimstoneMap) => CrimstoneGroup(
        amount: crimstoneMap['amount'],
        quantityGroup: crimstoneMap['quantityGroup'],
        quantitiesWithValues: crimstoneMap['quantitiesWithValues'],
        earliestMinedAt: crimstoneMap['time'],
      ),
      getName: (_) => 'Crimstone',
      getAmount: (crimstone) => crimstone.stone!.amount!,
      getTime: (crimstone) => crimstone.stone!.minedAt!,
    );
  }

  void updateSunstonesFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<SunstoneModel, SunstoneGroup>(
      jsonMap: jsonMap,
      fromJson: SunstoneModel.fromJson,
      fromGroupMap: (sunstoneMap) => SunstoneGroup(
        amount: sunstoneMap['amount'],
        quantityGroup: sunstoneMap['quantityGroup'],
        quantitiesWithValues: sunstoneMap['quantitiesWithValues'],
        earliestMinedAt: sunstoneMap['time'],
      ),
      getName: (_) => 'Sunstone',
      getAmount: (sunstone) => sunstone.stone!.amount!,
      getTime: (sunstone) => sunstone.stone!.minedAt!,
    );
  }

  void updateOilReservesFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<OilReserveModel, OilReserveGroup>(
      jsonMap: jsonMap,
      fromJson: OilReserveModel.fromJson,
      fromGroupMap: (oilMap) => OilReserveGroup(
        amount: oilMap['amount'],
        quantityGroup: oilMap['quantityGroup'],
        quantitiesWithValues: oilMap['quantitiesWithValues'],
        earliestDrilledAt: oilMap['time'],
      ),
      getName: (_) => 'Oil',
      getAmount: (oil) => oil.oil!.amount!,
      getTime: (oil) => oil.oil!.drilledAt!,
    );
  }

  void updateFruitPatchesFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<FruitPatchModel, FruitPatchGroup>(
      jsonMap: jsonMap,
      fromJson: FruitPatchModel.fromJson,
      fromGroupMap: (fruitMap) => FruitPatchGroup(
        name: fruitMap['name'],
        amount: fruitMap['amount'],
        quantityGroup: fruitMap['quantityGroup'],
        quantitiesWithValues: fruitMap['quantitiesWithValues'],
        earliestHarvestedAt: fruitMap['time'],
      ),
      getName: (fruit) => fruit.fruit?.name ?? 'Unknown',
      getAmount: (fruit) => fruit.fruit?.amount ?? 0,
      getTime: (fruit) => fruit.fruit!.harvestedAt != 0
          ? fruit.fruit!.harvestedAt!
          : fruit.fruit!.plantedAt!,
    );
  }

  void updateFlowerBedsFromJson(Map<String, dynamic> jsonMap) {
    updateItemsFromJson<FlowerBedModel, FlowerBedGroup>(
      jsonMap: jsonMap,
      fromJson: FlowerBedModel.fromJson,
      fromGroupMap: (flowerMap) {
        log(flowerMap.toString());
        return FlowerBedGroup(
          name: flowerMap['name'],
          amount: flowerMap['amount'],
          quantityGroup: flowerMap['quantityGroup'],
          quantitiesWithValues: flowerMap['quantitiesWithValues'],
          earliestPlantedAt: flowerMap['time'],
        );
      },
      getName: (flower) => flower.flower?.name ?? 'Unknown',
      getAmount: (flower) => flower.flower?.amount ?? 0,
      getTime: (flower) => flower.flower?.plantedAt ?? 0,
    );
  }
}
