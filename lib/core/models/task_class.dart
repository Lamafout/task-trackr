import 'package:hive/hive.dart';
import 'package:task_trackr/config/task_statuses.dart';

part 'task_class.g.dart';

@HiveType(typeId: 1)
class TaskClass {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final TaskStatuses? status;
  @HiveField(3)
  String? projectID;
  @HiveField(4)
  String? projectName;

  TaskClass({this.id, this.title, this.status, this.projectID});
}