import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';
import 'package:sunflower_tools/modules/shared/models/stone_model.dart';

class SunstoneModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  int? minesLeft;
  Stone? stone;

  SunstoneModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.minesLeft,
    this.stone,
  });

  factory SunstoneModel.fromJson(Map<String, dynamic> json) {
    return SunstoneModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      y: json['y']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      height: json['height']?.toInt(),
      minesLeft: json['minesLeft']?.toInt(),
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
      'minesLeft': minesLeft,
      'stone': stone?.toJson(),
    };
  }
}

class SunstoneGroup {
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int earliestMinedAt;

  SunstoneGroup({
    required this.amount,
    required this.quantityGroup,
    required this.quantitiesWithValues,
    required this.earliestMinedAt,
  });
}
