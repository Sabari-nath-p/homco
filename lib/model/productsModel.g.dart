// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class productModelAdapter extends TypeAdapter<productModel> {
  @override
  final int typeId = 2;

  @override
  productModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return productModel(
      productName: fields[0] as String?,
      productCategory: fields[1] as String?,
      ingredientsList: (fields[2] as List?)?.cast<IngredientsList>(),
    );
  }

  @override
  void write(BinaryWriter writer, productModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.productCategory)
      ..writeByte(2)
      ..write(obj.ingredientsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is productModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IngredientsListAdapter extends TypeAdapter<IngredientsList> {
  @override
  final int typeId = 3;

  @override
  IngredientsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientsList(
      content: fields[0] as String?,
      quantity: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientsList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
