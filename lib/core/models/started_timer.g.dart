// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'started_timer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StartedTimerAdapter extends TypeAdapter<StartedTimer> {
  @override
  final int typeId = 4;

  @override
  StartedTimer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StartedTimer(
      task: fields[0] as TaskClass,
      startTime: fields[1] as String,
      pausedTime: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StartedTimer obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.pausedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartedTimerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
