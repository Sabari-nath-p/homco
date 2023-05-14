// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energycostModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnergyCostModelAdapter extends TypeAdapter<EnergyCostModel> {
  @override
  final int typeId = 7;

  @override
  EnergyCostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnergyCostModel(
      categoryName: fields[0] as String?,
      price: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, EnergyCostModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnergyCostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
