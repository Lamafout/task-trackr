import 'package:hive/hive.dart';

part 'project_statuses.g.dart';

@HiveType(typeId: 3)
enum ProjectStatuses {
  @HiveField(0)
  active('Активные', 'Активный'),
  @HiveField(1)
  finished('Завершённые', 'Завершен'),
  @HiveField(2)
  archive('В архиве', 'Архив');

  final String name;
  final String displayName;
  const ProjectStatuses(this.displayName, this.name);

  static ProjectStatuses fromString (String value) {
    return ProjectStatuses.values.firstWhere((elem) => elem.name == value);
  }

  static bool isCorrectStatus(String status) {
    return ['Активный', 'Завершен', 'Архив'].contains(status);
  }
}