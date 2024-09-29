import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';

class LocalSource {
  Future<void> setID(String userId) async {
    await di.get<SharedPreferences>().setString('user_id', userId);
  }
  String getID() {
    return di.get<SharedPreferences>().getString('user_id') == null
    ? throw NoIDException() 
    : di.get<SharedPreferences>().getString('user_id') as String;
  }
}