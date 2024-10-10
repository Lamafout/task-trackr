// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statuses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusesAdapter extends TypeAdapter<Statuses> {
  @override
  final int typeId = 2;

  @override
  Statuses read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Statuses.todo;
      case 1:
        return Statuses.canDo;
      case 2:
        return Statuses.onHold;
      case 3:
        return Statuses.waiting;
      case 4:
        return Statuses.inProgress;
      case 5:
        return Statuses.needDiscussion;
      case 6:
        return Statuses.codeReview;
      case 7:
        return Statuses.internalReview;
      default:
        return Statuses.todo;
    }
  }

  @override
  void write(BinaryWriter writer, Statuses obj) {
    switch (obj) {
      case Statuses.todo:
        writer.writeByte(0);
        break;
      case Statuses.canDo:
        writer.writeByte(1);
        break;
      case Statuses.onHold:
        writer.writeByte(2);
        break;
      case Statuses.waiting:
        writer.writeByte(3);
        break;
      case Statuses.inProgress:
        writer.writeByte(4);
        break;
      case Statuses.needDiscussion:
        writer.writeByte(5);
        break;
      case Statuses.codeReview:
        writer.writeByte(6);
        break;
      case Statuses.internalReview:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
