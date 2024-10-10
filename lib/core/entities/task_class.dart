import 'package:hive/hive.dart';
import 'package:task_trackr/config/statuses.dart';

part 'task_class.g.dart';

@HiveType(typeId: 1)
class TaskClass {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final Statuses? status;

  TaskClass({this.id, this.title, this.status});
}