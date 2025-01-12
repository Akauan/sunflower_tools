import 'package:sunflower_tools/modules/shared/models/crop_model.dart';
import 'package:sunflower_tools/modules/shared/models/fetiliser_model.dart';

class FieldModel {
  int? x;
  int? width;
  int? createdAt;
  int? y;
  int? height;
  CropModel? crop;
  Fertiliser? fertiliser;

  FieldModel({
    this.x,
    this.width,
    this.createdAt,
    this.y,
    this.height,
    this.crop,
    this.fertiliser,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      x: json['x']?.toInt(),
      width: json['width']?.toInt(),
      createdAt: json['createdAt']?.toInt(),
      y: json['y']?.toInt(),
      height: json['height']?.toInt(),
      crop: json['crop'] != null ? CropModel.fromJson(json['crop']) : null,
      fertiliser: json['fertiliser'] != null
          ? Fertiliser.fromJson(json['fertiliser'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'width': width,
      'createdAt': createdAt,
      'y': y,
      'height': height,
      'crop': crop?.toJson(),
      'fertiliser': fertiliser?.toJson(),
    };
  }
}
