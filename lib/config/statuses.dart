import 'package:hive/hive.dart';

part 'statuses.g.dart';

@HiveType(typeId: 2)
enum Statuses {
  @HiveField(0)
  todo('Формируется'),
  @HiveField(1)
  canDo('Можно делать'),
  @HiveField(2)
  onHold('На паузе'),
  @HiveField(3)
  waiting('Ожидание'),
  @HiveField(4)
  inProgress('В работе'),
  @HiveField(5)
  needDiscussion('Надо обсудить'),
  @HiveField(6)
  codeReview('Код-ревью'),
  @HiveField(7)
  internalReview('Внутренняя проверка');

  final String displayName;
  const Statuses(this.displayName);

  static Statuses fromString (String value) {
    return Statuses.values.firstWhere((elem) => elem.displayName == value);
  }
}