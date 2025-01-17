import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sunflower_tools/modules/home/components/crimstone_tile_component.dart.dart';
import 'package:sunflower_tools/modules/home/components/crop_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/flower_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/fruit_patch_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/gold_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/iron_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/oil_reserve_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/stone_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/sunstone_tile_component.dart';
import 'package:sunflower_tools/modules/home/components/tree_tile_component.dart';
import 'package:sunflower_tools/modules/home/controllers/home_controller.dart';
import 'package:sunflower_tools/modules/login/controllers/login_controller.dart';
import 'package:sunflower_tools/modules/shared/components/appbar_component.dart';
import 'package:sunflower_tools/modules/shared/components/container_component.dart';
import 'package:sunflower_tools/modules/shared/components/drawer_component.dart';
import 'package:sunflower_tools/modules/shared/components/item_list_component.dart';
import 'package:sunflower_tools/modules/shared/components/search_icon_component.dart';
import 'package:sunflower_tools/modules/shared/components/text_component.dart';
import 'package:sunflower_tools/modules/shared/constants/size_constants.dart';
import 'package:sunflower_tools/modules/shared/controllers/grouped_controller.dart';
import 'package:sunflower_tools/modules/shared/config/farm_service.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final FarmService farmService = FarmService();
  final HomeController _homeController = Get.find<HomeController>();
  final LoginController _loginController = Get.find<LoginController>();
  final GroupedController groupedController = Get.find<GroupedController>();

  @override
  void initState() {
    super.initState();

    // Define o intervalo desejado em minutos
    farmService.intervalMinutes.value =
        int.parse(_loginController.refreshTime.text);
    // Inicia a tarefa periódica para buscar dados
    farmService.startPeriodicTask(int.parse(_loginController.userLandId.text));
  }

  Future<void> reloadData() async {
    // Realiza a fetch inicial dos dados
    farmService.performInitialFetchIfNeeded(
      int.parse(_loginController.userLandId.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBarComponent(
                name: 'Farm Info',
                actions: [
                  // Button to show the search field
                  SearchIconComponent(
                    showSearch: _homeController.showSearch,
                    clearList: _homeController.clearFilter,
                    enabled: _homeController.searchEnabled.value,
                  ),
                ],
              ),
              drawer: const DrawerComponent(),
              drawerEnableOpenDragGesture: true,
              body: Obx(
                () {
                  // Isso agora monitora a execução do Future e atualiza quando `_listInventory` mudar
                  return FutureBuilder(
                    future: farmService.listInventory.value,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return ContainerComponent(
                          constraints: constraints,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const TextComponent(
                                  text: 'An error occurred. Please try again!',
                                  size: kFontSizeMedium,
                                  minFontSize: kFontSizeMedium,
                                  color: ThemeColor.greyColor,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: reloadData,
                                  child: const Text('Reload'),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ContainerComponent(
                          constraints: constraints,
                          child: Padding(
                            padding: const EdgeInsets.all(kPaddingStandard),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kRadiusMedium),
                              ),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: ThemeColor.whiteColor),
                                child: Center(
                                  child:
                                      Lottie.asset('assets/jsons/loading.json'),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ContainerComponent(
                          constraints: constraints,
                          child: Padding(
                            padding: const EdgeInsets.all(kPaddingStandard),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kRadiusMedium),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(kRadiusMedium),
                                      child: ItemListComponent(
                                        onRefresh: reloadData,
                                        items: groupedController
                                            .inventoryListItems,
                                        itemBuilder: (item) {
                                          final componentsMap = {
                                            'crop': (data) =>
                                                CropTileComponent(field: data),
                                            'tree': (data) =>
                                                TreeTileComponent(tree: data),
                                            'stone': (data) =>
                                                StoneTileComponent(stone: data),
                                            'iron': (data) =>
                                                IronTileComponent(iron: data),
                                            'gold': (data) =>
                                                GoldTileComponent(gold: data),
                                            'crimstone': (data) =>
                                                CrimstoneTileComponent(
                                                    crimstone: data),
                                            'sunstone': (data) =>
                                                SunstoneTileComponent(
                                                    sunstone: data),
                                            'oil': (data) =>
                                                OilReserveTileComponent(
                                                    oilReserve: data),
                                            'fruit': (data) =>
                                                FruitPatchTileComponent(
                                                    fruitPatch: data),
                                            'flower': (data) =>
                                                FlowerBedTileComponent(
                                                    flowerBed: data),
                                          };

                                          return componentsMap[item['type']]!(
                                              item['data']);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              )),
        );
      },
    );
  }
}
