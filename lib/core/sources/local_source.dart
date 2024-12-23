import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/running_timer_state_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

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
    projects.sort((a, b) => a.status!.index.compareTo(b.status!.index));
    return projects;
  }

  Future<void> saveProjects(List<Project> projects) async {
    final box = di<Box<Project>>();
    await box.clear();
    for (var project in projects) {
      box.put(project.id, project);
    }  }

  Future<List<TaskClass>> getTasks(String projectID) async {
    final box = di.get<Box<TaskClass>>();
    final List<TaskClass> tasks = box.values.where((task) => task.projectID == projectID).toList();
    tasks.sort((a, b) => a.status!.index.compareTo(b.status!.index));
    return tasks;
  }

  Future<void> saveTasks(List<TaskClass> tasks) async {
    final box = di<Box<TaskClass>>();
    await box.clear();
    for (var task in tasks) {
      box.put(task.id, task);
    }
  }

  Future<void> saveTimerState(TimerIsWorksState state) async {
    final box = di<Box<RunningTimerState>>();
    box.put('state', RunningTimerState.fromState(state));
  }

   Future<TimerIsWorksState?> getTimerState() async {
     final box = di<Box<RunningTimerState>>();
     final state = box.get('state');
     return state?.toState();
   }

   Future<void> clearStates() async {
     final box = di<Box<RunningTimerState>>();
     box.clear();
   }
}