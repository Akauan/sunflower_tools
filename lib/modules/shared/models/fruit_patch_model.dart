import 'package:sunflower_tools/modules/shared/models/fetiliser_model.dart';
import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';

class FruitPatchModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  Fruit? fruit;
  Fertiliser? fertiliser;

  FruitPatchModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.fruit,
    this.fertiliser,
  });

  factory FruitPatchModel.fromJson(Map<String, dynamic> json) {
    return FruitPatchModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      y: json['y']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      height: json['height']?.toInt(),
      fruit: json['fruit'] != null ? Fruit.fromJson(json['fruit']) : null,
      fertiliser: json['fertiliser'] != null
          ? Fertiliser.fromJson(json['fertiliser'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'width': width,
      'y': y,
      'createdAt': createdAt,
      'height': height,
      'fruit': fruit?.toJson(),
      'fertiliser': fertiliser?.toJson(),
    };
  }
}

class Fruit {
  String? name;
  int? plantedAt;
  double? amount;
  int? harvestedAt;
  int? harvestsLeft;

  Fruit({
    this.name,
    this.plantedAt,
    this.amount,
    this.harvestedAt,
    this.harvestsLeft,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      name: json['name'],
      plantedAt: json['plantedAt']?.toInt(),
      amount: json['amount']?.toDouble(),
      harvestedAt: json['harvestedAt']?.toInt(),
      harvestsLeft: json['harvestsLeft']?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'plantedAt': plantedAt,
      'amount': amount,
      'harvestedAt': harvestedAt,
      'harvestsLeft': harvestsLeft,
    };
  }
}

class FruitPatchGroup {
  String name; // Nome do grupo de frutas.
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int earliestHarvestedAt;

  FruitPatchGroup({
    required this.name,
    required this.amount,
    required this.quantityGroup,
    required this.quantitiesWithValues,
    required this.earliestHarvestedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'quantityGroup': quantityGroup,
      'quantitiesWithValues':
          quantitiesWithValues.map((qv) => qv.toJson()).toList(),
      'earliestHarvestedAt': earliestHarvestedAt,
    };
  }
}
