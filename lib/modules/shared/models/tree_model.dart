import 'package:sunflower_tools/modules/shared/models/quantity_value_model.dart';
import 'package:sunflower_tools/modules/shared/models/reward_model.dart';

class TreeModel {
  int? x;
  int? width;
  int? y;
  int? createdAt;
  int? height;
  Reward? reward;
  Wood? wood;

  TreeModel({
    this.x,
    this.width,
    this.y,
    this.createdAt,
    this.height,
    this.wood,
    this.reward,
  });

  factory TreeModel.fromJson(Map<String, dynamic> json) {
    return TreeModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      y: json['y']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      height: json['height']?.toInt(),
      wood: json['wood'] != null ? Wood.fromJson(json['wood']) : null,
      reward: json['reward'] != null ? Reward.fromJson(json['reward']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'width': width,
      'y': y,
      'createdAt': createdAt,
      'height': height,
      'wood': wood?.toJson(),
      'reward': reward?.toJson(),
    };
  }
}

class Wood {
  int? choppedAt;
  double? amount;

  Wood({
    this.choppedAt,
    this.amount,
  });

  factory Wood.fromJson(Map<String, dynamic> json) {
    return Wood(
      choppedAt: json['choppedAt']?.toInt(),
      amount: json['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'choppedAt': choppedAt,
      'amount': amount,
    };
  }
}

class TreeGroup {
  double amount;
  int quantityGroup;
  List<QuantityValue> quantitiesWithValues;
  int? earliestChoppedAt;
  Reward? reward;

  TreeGroup({
    required this.amount,
    this.quantityGroup = 1,
    required this.quantitiesWithValues,
    this.earliestChoppedAt,
    this.reward,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'quantityGroup': quantityGroup,
      'quantitiesWithValues':
          quantitiesWithValues.map((qv) => qv.toJson()).toList(),
      'earliestChoppedAt': earliestChoppedAt,
      'reward': reward?.toJson(),
    };
  }
}
