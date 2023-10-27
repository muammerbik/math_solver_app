// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PremiumModelAdapter extends TypeAdapter<PremiumModel> {
  @override
  final int typeId = 0;

  @override
  PremiumModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PremiumModel(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PremiumModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.secilenValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PremiumModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
