// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manpowerModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class manpowerModelAdapter extends TypeAdapter<manpowerModel> {
  @override
  final int typeId = 5;

  @override
  manpowerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return manpowerModel(
      id: fields[0] as int?,
      categoryName: fields[1] as String?,
      packing: (fields[2] as List?)?.cast<Packing>(),
    );
  }

  @override
  void write(BinaryWriter writer, manpowerModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryName)
      ..writeByte(2)
      ..write(obj.packing);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is manpowerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PackingAdapter extends TypeAdapter<Packing> {
  @override
  final int typeId = 6;

  @override
  Packing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Packing(
      quantity: fields[0] as double?,
      unit: fields[1] as String?,
      amount: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Packing obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
