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

class NewsUseCase {
  // сорсы имплментируют классы по типу drift_local_source и rest_remote_source. Они находятся в корне проекта и имеют в себе все нужные методы
  final LocalSource _ls;
  final RemoteSource _rs; 

  GetNewsUseCase(this._rs, this._ls);

  Stream<DataState<List<News>>> getNews() async* {
    return DataHelper( // возвращает как раз-таки стрим
      fetchLocal: _ls.queryNews, // возвращает просто-напросто список
      
      fetchRemote: _rs.queryNews, // возвращает просто-напросто список
      
      saveLocal: _ls.batchNews, // принимает в себя список
      
      strategy: CacheStrategy.cacheFirst, 
    );
  }

  Future<DataState<void>> setNewsAsFavourite(int newsId) async {
    // представим, что токенов на проекте нет
    final user = await _ls.queryUser;
    return _rs.setNewsAsFavourite(user.id);
  }
}