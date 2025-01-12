import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';
import 'package:sunflower_tools/modules/shared/models/stone_model.dart';

class GoldModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  Stone? stone;

  GoldModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.stone,
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) {
    return GoldModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      y: json['y']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      height: json['height']?.toInt(),
      stone: json['stone'] != null ? Stone.fromJson(json['stone']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'width': width,
      'y': y,
      'createdAt': createdAt,
      'height': height,
      'stone': stone?.toJson(),
    };
  }
}

class GoldGroup {
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int earliestMinedAt;

  GoldGroup({
    required this.amount,
    required this.quantityGroup,
    required this.quantitiesWithValues,
    required this.earliestMinedAt,
  });
}
