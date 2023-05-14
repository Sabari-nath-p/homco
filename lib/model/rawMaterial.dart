import 'package:hive/hive.dart';

part 'rawMaterial.g.dart';

@HiveType(typeId: 1)
class RawMaterialModel {
  @HiveField(0)
  String? materialName;
  @HiveField(1)
  double? price;
  @HiveField(2)
  String? unit = "ml";

  RawMaterialModel({this.materialName, this.price, this.unit});

  RawMaterialModel.fromJson(Map<String, dynamic> json) {
    materialName = json['material_name'];
    price = json['price'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['material_name'] = this.materialName;
    data['price'] = this.price;
    data['unit'] = this.unit;
    return data;
  }
}
