import 'package:hive/hive.dart';

part 'project_statuses.g.dart';

@HiveType(typeId: 3)
enum ProjectStatuses {
  @HiveField(0)
  active('Активный'),
  @HiveField(1)
  finished('Завершен'),
  @HiveField(2)
  archive('Архив');

  final String displayName;
  const ProjectStatuses(this.displayName);

  static ProjectStatuses fromString (String value) {
    return ProjectStatuses.values.firstWhere((elem) => elem.displayName == value);
  }
}