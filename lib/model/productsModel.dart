import 'package:hive_flutter/adapters.dart';
part 'productsModel.g.dart';

@HiveType(typeId: 2)
class productModel {
  @HiveField(0)
  String? productName;
  @HiveField(1)
  String? productCategory;
  @HiveField(2)
  List<IngredientsList>? ingredientsList;

  productModel({this.productName, this.productCategory, this.ingredientsList});

  productModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productCategory = json['product_category'];
    if (json['ingredients_list'] != null) {
      ingredientsList = <IngredientsList>[];
      json['ingredients_list'].forEach((v) {
        ingredientsList!.add(new IngredientsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_category'] = this.productCategory;
    if (this.ingredientsList != null) {
      data['ingredients_list'] =
          this.ingredientsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3)
class IngredientsList {
  @HiveField(0)
  String? content;
  @HiveField(1)
  double? quantity;

  IngredientsList({this.content, this.quantity});

  IngredientsList.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['quantity'] = this.quantity;
    return data;
  }
}
