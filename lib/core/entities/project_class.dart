import 'package:hive/hive.dart';
import 'package:task_trackr/config/statuses.dart';

part 'project_class.g.dart';

@HiveType(typeId: 0)
class Project {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? icon;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final Statuses? status;

  Project({required this.id, required this.icon, required this.name, required this.status});
}