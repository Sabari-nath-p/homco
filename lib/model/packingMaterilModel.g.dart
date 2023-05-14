// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packingMaterilModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class packingmaterialModelAdapter extends TypeAdapter<packingmaterialModel> {
  @override
  final int typeId = 4;

  @override
  packingmaterialModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return packingmaterialModel(
      packName: fields[0] as String?,
      quantity: fields[1] as double?,
      unit: fields[2] as String?,
      price: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, packingmaterialModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.packName)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is packingmaterialModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
