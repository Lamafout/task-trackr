import 'dart:ui';

import 'package:hive/hive.dart';

part 'task_statuses.g.dart';

@HiveType(typeId: 2)
enum TaskStatuses {
  @HiveField(0)
  todo(displayName: 'Формируется', color: Color(0xFF9b9b9b)),
  @HiveField(1)
  canDo(displayName: 'Можно делать', color: Color(0xFF007AFF)),
  @HiveField(2)
  onHold(displayName: 'На паузе', color: Color.fromRGBO(174, 174, 178, 1.0)),
  @HiveField(3)
  waiting(displayName: 'Ожидание', color: Color.fromRGBO(174, 174, 178, 1.0)),
  @HiveField(4)
  inProgress(displayName: 'В работе', color: Color(0xFFFFCC00)),
  @HiveField(5)
  needDiscussion(displayName: 'Надо обсудить', color: Color(0xFFad755d)),
  @HiveField(6)
  codeReview(displayName: 'Код-ревью', color: Color(0xFF34C759)),
  @HiveField(7)
  internalReview(displayName: 'Внутренняя проверка', color: Color(0xFFFF2D55)),
  @HiveField(8)
  canUnload(displayName: 'Можно выгружать', color: Color(0xFF5856D6)),
   @HiveField(9)
  verification(displayName: 'Проверерка клиентом', color: Color(0xFFFF9500)),
   @HiveField(10)
  canceled(displayName: 'Отменена', color: Color(0xFFFF3B30)),
   @HiveField(11)
  done(displayName: 'Готова', color: Color(0xFF34C759));


  final String displayName;
  final Color color;
  const TaskStatuses({required this.displayName, required this.color});

  static TaskStatuses fromString (String value) {
    return TaskStatuses.values.firstWhere((elem) => elem.displayName == value);
  }
}