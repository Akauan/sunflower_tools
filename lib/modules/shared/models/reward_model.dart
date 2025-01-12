import 'package:sunflower_tools/modules/shared/models/generic_item_model.dart';

class Reward {
  List<Item>? items;

  Reward({this.items});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => Item.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((item) => item.toJson()).toList(),
    };
  }
}
