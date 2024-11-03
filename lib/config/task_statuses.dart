import 'dart:ui';

import 'package:hive/hive.dart';

part 'task_statuses.g.dart';

@HiveType(typeId: 2)
enum TaskStatuses {
  @HiveField(0)
  todo(displayName: 'Формируется', color: Color(0xFF9b9b9b)),
  @HiveField(1)
  canDo(displayName: 'Можно делать', color: Color(0xFF2c7ecd)),
  @HiveField(2)
  onHold(displayName: 'На паузе', color: Color(0xFF9b9b9b)),
  @HiveField(3)
  waiting(displayName: 'Ожидание', color: Color(0xFF9b9b9b)),
  @HiveField(4)
  inProgress(displayName: 'В работе', color: Color(0xFFcc8d13)),
  @HiveField(5)
  needDiscussion(displayName: 'Надо обсудить', color: Color(0xFFad755d)),
  @HiveField(6)
  codeReview(displayName: 'Код-ревью', color: Color(0xFF309664)),
  @HiveField(7)
  internalReview(displayName: 'Внутренняя проверка', color: Color(0xFF309664));

  final String displayName;
  final Color color;
  const TaskStatuses({required this.displayName, required this.color});

  static TaskStatuses fromString (String value) {
    return TaskStatuses.values.firstWhere((elem) => elem.displayName == value);
  }
}