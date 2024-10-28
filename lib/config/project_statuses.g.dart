// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_statuses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectStatusesAdapter extends TypeAdapter<ProjectStatuses> {
  @override
  final int typeId = 3;

  @override
  ProjectStatuses read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ProjectStatuses.active;
      case 1:
        return ProjectStatuses.finished;
      case 2:
        return ProjectStatuses.archive;
      default:
        return ProjectStatuses.active;
    }
  }

  @override
  void write(BinaryWriter writer, ProjectStatuses obj) {
    switch (obj) {
      case ProjectStatuses.active:
        writer.writeByte(0);
        break;
      case ProjectStatuses.finished:
        writer.writeByte(1);
        break;
      case ProjectStatuses.archive:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectStatusesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
