import 'package:sunflower_tools/modules/shared/models/fetiliser_model.dart';
import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';
import 'package:sunflower_tools/modules/shared/models/reward_model.dart';

class CropModel {
  String? id;
  int? plantedAt;
  String? name;
  double? amount;
  Reward? reward;
  int? quantityGroup;

  CropModel({
    this.id,
    this.plantedAt,
    this.name,
    this.amount,
    this.reward,
    this.quantityGroup,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      id: json['id'],
      plantedAt: json['plantedAt']?.toInt(),
      name: json['name'],
      amount: json['amount']?.toDouble(),
      reward: json['reward'] != null ? Reward.fromJson(json['reward']) : null,
      quantityGroup: json['quantityGroup']?.toInt(),
    );
  }

  get fertiliser => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plantedAt': plantedAt,
      'name': name,
      'amount': amount,
      'reward': reward?.toJson(),
      'quantityGroup': quantityGroup,
    };
  }
}

class CropGroup {
  String name;
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  Reward? reward;
  Fertiliser? fertiliser;
  int? earliestPlantedAt;

  CropGroup({
    required this.name,
    required this.amount,
    this.quantityGroup = 1,
    required this.quantitiesWithValues,
    this.reward,
    this.fertiliser,
    this.earliestPlantedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'quantityGroup': quantityGroup,
      'quantitiesWithValues':
          quantitiesWithValues.map((qv) => qv.toJson()).toList(),
      'reward': reward?.toJson(),
      'fertiliser': fertiliser?.toJson(),
      'earliestPlantedAt': earliestPlantedAt,
    };
  }
}
