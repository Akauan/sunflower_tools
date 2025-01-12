import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';
import 'package:sunflower_tools/modules/shared/models/stone_model.dart';

class IronModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  Stone? stone;

  IronModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.stone,
  });

  factory IronModel.fromJson(Map<String, dynamic> json) {
    return IronModel(
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

class IronGroup {
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int? earliestMinedAt;

  IronGroup({
    required this.amount,
    this.quantityGroup = 1,
    required this.quantitiesWithValues,
    this.earliestMinedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'quantityGroup': quantityGroup,
      'quantitiesWithValues':
          quantitiesWithValues.map((qv) => qv.toJson()).toList(),
      'earliestMinedAt': earliestMinedAt,
    };
  }
}
