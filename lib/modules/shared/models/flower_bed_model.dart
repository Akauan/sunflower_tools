import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';

class FlowerBedModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  Flower? flower;

  FlowerBedModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.flower,
  });

  factory FlowerBedModel.fromJson(Map<String, dynamic> json) {
    return FlowerBedModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      y: json['y']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      height: json['height']?.toInt(),
      flower: json['flower'] != null ? Flower.fromJson(json['flower']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'width': width,
      'y': y,
      'createdAt': createdAt,
      'height': height,
      'flower': flower?.toJson(),
    };
  }
}

class Flower {
  String? name;
  int? plantedAt;
  double? amount;

  Flower({
    this.name,
    this.plantedAt,
    this.amount,
  });

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      name: json['name'],
      plantedAt: json['plantedAt']?.toInt(),
      amount: json['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'plantedAt': plantedAt,
      'amount': amount,
    };
  }
}

class FlowerBedGroup {
  String name; // Nome do grupo de flores.
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int earliestPlantedAt;

  FlowerBedGroup({
    required this.name,
    required this.amount,
    required this.quantityGroup,
    required this.quantitiesWithValues,
    required this.earliestPlantedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'quantityGroup': quantityGroup,
      'quantitiesWithValues':
          quantitiesWithValues.map((qv) => qv.toJson()).toList(),
      'earliestPlantedAt': earliestPlantedAt,
    };
  }
}
