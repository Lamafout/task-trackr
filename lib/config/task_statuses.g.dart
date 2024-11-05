// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_statuses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskStatusesAdapter extends TypeAdapter<TaskStatuses> {
  @override
  final int typeId = 2;

  @override
  TaskStatuses read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskStatuses.todo;
      case 1:
        return TaskStatuses.canDo;
      case 2:
        return TaskStatuses.onHold;
      case 3:
        return TaskStatuses.waiting;
      case 4:
        return TaskStatuses.inProgress;
      case 5:
        return TaskStatuses.needDiscussion;
      case 6:
        return TaskStatuses.codeReview;
      case 7:
        return TaskStatuses.internalReview;
      case 8:
        return TaskStatuses.canUnload;
      case 9:
        return TaskStatuses.verification;
      case 10:
        return TaskStatuses.canceled;
      case 11:
        return TaskStatuses.done;
      default:
        return TaskStatuses.todo;
    }
  }

  @override
  void write(BinaryWriter writer, TaskStatuses obj) {
    switch (obj) {
      case TaskStatuses.todo:
        writer.writeByte(0);
        break;
      case TaskStatuses.canDo:
        writer.writeByte(1);
        break;
      case TaskStatuses.onHold:
        writer.writeByte(2);
        break;
      case TaskStatuses.waiting:
        writer.writeByte(3);
        break;
      case TaskStatuses.inProgress:
        writer.writeByte(4);
        break;
      case TaskStatuses.needDiscussion:
        writer.writeByte(5);
        break;
      case TaskStatuses.codeReview:
        writer.writeByte(6);
        break;
      case TaskStatuses.internalReview:
        writer.writeByte(7);
        break;
      case TaskStatuses.canUnload:
        writer.writeByte(8);
        break;
      case TaskStatuses.verification:
        writer.writeByte(9);
        break;
      case TaskStatuses.canceled:
        writer.writeByte(10);
        break;
      case TaskStatuses.done:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStatusesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
