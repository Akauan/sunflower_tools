import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';

class StoneModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  Stone? stone;

  StoneModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.stone,
  });

  factory StoneModel.fromJson(Map<String, dynamic> json) {
    return StoneModel(
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

class Stone {
  int? minedAt;
  double? amount;

  Stone({
    this.minedAt,
    this.amount,
  });

  factory Stone.fromJson(Map<String, dynamic> json) {
    return Stone(
      minedAt: json['minedAt']?.toInt(),
      amount: json['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minedAt': minedAt,
      'amount': amount,
    };
  }
}

class StoneGroup {
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int? earliestMinedAt;

  StoneGroup({
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
