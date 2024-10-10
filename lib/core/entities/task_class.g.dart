// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskClassAdapter extends TypeAdapter<TaskClass> {
  @override
  final int typeId = 1;

  @override
  TaskClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskClass(
      id: fields[0] as String?,
      title: fields[1] as String?,
      status: fields[2] as Statuses?,
      projectID: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.projectID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
