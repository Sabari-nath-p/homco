import 'package:hive_flutter/hive_flutter.dart';
part 'manpowerModel.g.dart';
@HiveType(typeId: 5)
class manpowerModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? categoryName;
  @HiveField(2)
  List<Packing>? packing;

  manpowerModel({this.id, this.categoryName, this.packing});

  manpowerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    if (json['packing'] != null) {
      packing = <Packing>[];
      json['packing'].forEach((v) {
        packing!.add(new Packing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    if (this.packing != null) {
      data['packing'] = this.packing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



@HiveType(typeId: 6)
class Packing {
  @HiveField(0)
  double? quantity;
  @HiveField(1)
  String? unit;
  @HiveField(2)
  double? amount;

  Packing({this.quantity, this.unit, this.amount});

  Packing.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    unit = json['unit'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['amount'] = this.amount;
    return data;
  }
}