import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';

class OilReserveModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  int? drilled;
  Oil? oil;

  OilReserveModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.drilled,
    this.oil,
  });

  factory OilReserveModel.fromJson(Map<String, dynamic> json) {
    return OilReserveModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      y: json['y']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      height: json['height']?.toInt(),
      drilled: json['drilled']?.toInt(),
      oil: json['oil'] != null ? Oil.fromJson(json['oil']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'width': width,
      'y': y,
      'createdAt': createdAt,
      'height': height,
      'drilled': drilled,
      'oil': oil?.toJson(),
    };
  }
}

class Oil {
  int? drilledAt;
  double? amount;

  Oil({
    this.drilledAt,
    this.amount,
  });

  factory Oil.fromJson(Map<String, dynamic> json) {
    return Oil(
      drilledAt: json['drilledAt']?.toInt(),
      amount: json['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drilledAt': drilledAt,
      'amount': amount,
    };
  }
}

class OilReserveGroup {
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int earliestDrilledAt;

  OilReserveGroup({
    required this.amount,
    required this.quantityGroup,
    required this.quantitiesWithValues,
    required this.earliestDrilledAt,
  });
}
