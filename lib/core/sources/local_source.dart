import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/config/statuses.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
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
  Future<void> setEmployee(Employee employee) async {
    await di.get<SharedPreferences>().setString('name', employee.name ?? '');
    await di.get<SharedPreferences>().setString('email', employee.email ?? '');
    await di.get<SharedPreferences>().setString('phone', employee.photo ?? '');
    await di.get<SharedPreferences>().setString('user_id', employee.id ?? '');
  }

  Future<List<Project>> getProjects() async {
    final box = di.get<Box<Project>>();
    final List<Project> projects = box.values.toList();
    return projects;
  }

  Future<void> saveProjects(List<Project> projects) async {
    final box = di<Box<Project>>();
    for (var project in projects) {
      box.put(project.id, project);
    }
  }

  Future<List<TaskClass>> getTasks(String projectID) async {
    final box = di.get<Box<TaskClass>>();
    final List<TaskClass> tasks = box.values.where((task) => task.projectID == projectID).toList();
    tasks.sort((a, b) => (a.status as Statuses).index.compareTo((b.status as Statuses).index));
    return tasks;
  }

  Future<void> saveTasks(List<TaskClass> tasks) async {
    final box = di<Box<TaskClass>>();
    for (var task in tasks) {
      box.put(task.id, task);
    }
  }
}