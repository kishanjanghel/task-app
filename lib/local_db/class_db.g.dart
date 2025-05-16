// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassHiveModelAdapter extends TypeAdapter<ClassHiveModel> {
  @override
  final int typeId = 3;

  @override
  ClassHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassHiveModel(
      className: fields[0] as String?,
      subjects: (fields[1] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ClassHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
