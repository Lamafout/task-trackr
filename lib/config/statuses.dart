enum Statuses {
  todo('Формируется'),
  canDo('Можно делать'),
  onHold('На паузе'),
  waiting('Ожидание'),
  inProgress('В работе'),
  needDiscussion('Надо обсудить'),
  codeReview('Код-ревью'),
  internalReview('Внутренняя проверка');

  final String displayName;
  const Statuses(this.displayName);

  static Statuses fromString (String value) {
    return Statuses.values.firstWhere((elem) => elem.displayName == value);
  }
}