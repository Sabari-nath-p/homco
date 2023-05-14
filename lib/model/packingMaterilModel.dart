import 'package:hive_flutter/hive_flutter.dart';
part 'packingMaterilModel.g.dart';
@HiveType(typeId: 4)
class packingmaterialModel {
  @HiveField(0)
  String? packName;
  @HiveField(1)
  double? quantity;
  @HiveField(2)
  String? unit;
  @HiveField(3)
  String? price;

  packingmaterialModel({this.packName, this.quantity, this.unit, this.price});

  packingmaterialModel.fromJson(Map<String, dynamic> json) {
    packName = json['pack_name'];
    quantity = json['quantity'];
    unit = json['unit'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pack_name'] = this.packName;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price'] = this.price;
    return data;
  }
}