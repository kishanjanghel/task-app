// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherHiveModelAdapter extends TypeAdapter<TeacherHiveModel> {
  @override
  final int typeId = 1;

  @override
  TeacherHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherHiveModel(
      name: fields[0] as String?,
      subject: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TeacherHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subject);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
