import 'package:hive/hive.dart';

part 'energycostModel.g.dart';

@HiveType(typeId: 7)
class EnergyCostModel {
  @HiveField(0)
  String? categoryName;
  @HiveField(1)
  double? price;

  EnergyCostModel({this.categoryName, this.price});

  EnergyCostModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['price'] = this.price;
    return data;
  }
}
