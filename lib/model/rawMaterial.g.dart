// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rawMaterial.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RawMaterialModelAdapter extends TypeAdapter<RawMaterialModel> {
  @override
  final int typeId = 1;

  @override
  RawMaterialModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RawMaterialModel(
      materialName: fields[0] as String?,
      price: fields[1] as double?,
      unit: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RawMaterialModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.materialName)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RawMaterialModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
