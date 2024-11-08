// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'running_timer_state_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RunningTimerStateAdapter extends TypeAdapter<RunningTimerState> {
  @override
  final int typeId = 4;

  @override
  RunningTimerState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RunningTimerState(
      task: fields[0] as TaskClass,
      time: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RunningTimerState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RunningTimerStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
