import 'package:hive/hive.dart';

part 'project_class.g.dart';

@HiveType(typeId: 0)
class Project {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? icon;
  @HiveField(2)
  final String? picture;
  @HiveField(3)
  final String? name;

  Project({required this.id, required this.icon, required this.picture, required this.name});
}