import 'package:hive/hive.dart';

part 'project_statuses.g.dart';

@HiveType(typeId: 3)
enum ProjectStatuses {
  @HiveField(0)
  active('Активные'),
  @HiveField(1)
  finished('Завершённые'),
  @HiveField(2)
  archive('В архиве');

  final String displayName;
  const ProjectStatuses(this.displayName);

  static ProjectStatuses fromString (String value) {
    return ProjectStatuses.values.firstWhere((elem) => elem.displayName == value);
  }

  static bool isCorrectStatus(String status) {
    return ['Активный', 'Завершен', 'Архив'].contains(status);
  }
}