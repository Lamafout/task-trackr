import 'package:dio/dio.dart';
import 'package:task_trackr/config/api_paths.dart';
import 'package:task_trackr/config/paths_to_pages.dart';
import 'package:task_trackr/config/statuses.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';
import 'package:task_trackr/core/interceptors/header_interceptor.dart';

class RemoteSource {
  final Dio dio;
  RemoteSource() : dio = Dio() {
    dio.interceptors.add(di<HeaderInterceptor>());
  }
  Future<List<Employee>> getEmployees() async {
    final response = await dio.post(databaseUrl(peopleDatabasePath));

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['results'];
      final List<Employee> listOfEmployees = data.map((employee) {
        return Employee(
          id: employee['properties']['Ссылка']['people'][0]['id'] as String?,
          name: employee['properties']['Имя']['title'][0]['text']['content'] as String,
          email: employee['properties']['Email']['email'] as String?,
          photo: employee['icon'] != null ? employee['icon']['file']['url'] as String? : null,
        );
      }).toList();
      return listOfEmployees;
    } else {
      throw InternetException();
    }
  }

  Future<List<Project>> getProjects(employeeID) async {
    // на данном этапе из-за особенностей api список проектов пользователя получается в 2 этапа:
    // 1. получаем список id проектов из тасков с фильтром на исполнителя и на статус проекта
    // 2. получаем список проектов с фильтром на id проекта на содержание id из списка

    final List<String> ids = await getProjectsIDsOfEmployee(employeeID); // список id проектов
    // формируем запрос с условием на статус и на исполнителя (проверка на исполнителя через список проектов исполнителя, полученных через список тасков исполнителя)
    final response = await dio.post(
      databaseUrl(projectsDatabasePath),
      data: {
        'filter': {
          'property': 'Статус',
          'status': {
            'equals': 'Активный'
          }
        }
      },
    );
   
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['results'];
      final validatedData = data.where((project) => ids.contains(project['id']));
      print('прошли валидацию: $validatedData');
      final List<Project> listOfProjects = validatedData.map((project) {        
        return Project(
          id: project['id'],
          icon: project['icon'] != null
                ? project['icon']['file'] != null
                  ? project['icon']['file']['url']
                  : project['icon']['external'] != null
                    ? project['icon']['external']['url']
                    : project['icon']['emoji']
                : null,
          picture: (project['properties']['Картинка']['files'] as List).isNotEmpty 
                  ? project['properties']['Картинка']['files'][0]['file']['url']
                  : null,
          name: (project['properties']['Name']['title'] as List).isNotEmpty 
                ? project['properties']['Name']['title'][0]['text']['content'] 
                : null,
        );
      }).toList();


      print('создали список: $listOfProjects');
      return listOfProjects;
    } else {
      throw Exception();
    }
  }

  Future<List<String>> getProjectsIDsOfEmployee(String employeeID) async {
    final response = await dio.post(
      databaseUrl(tasksDatabasePath),
      data: {
        'filter': {
          'property': 'Исполнитель',
          'people': {
            'contains': employeeID
          }
        }
      }
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['results'];
      final Set<String> setOfIDs = data.map((task) {
        return task['properties']['Продукт']['relation'].isNotEmpty ? task['properties']['Продукт']['relation'][0]['id'] as String : '';
      }).toSet();
      return setOfIDs.toList();
    }
    else {
      throw Exception();
    }
  }

  Future<List<TaskClass>> getTasks({required String employeeID, required String projectID}) async {
    final response = await dio.post(
      databaseUrl(tasksDatabasePath),
      data: {
        'filter': {
          'and': [
            {
              'property': 'Исполнитель',
              'people': {
                'contains': employeeID
              }
            },
            {
              'property': 'Продукт',
              'relation': {
                'contains': projectID
              }
            },
          ]
        }
      }
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['results'];
      final List<TaskClass> listOfTasks = data.map((task) {
        return TaskClass(
          id: task['id'],
          title: task['properties']['Full name'] != null ? task['properties']['Full name']['formula']['string'] : 'Unnamed task',
          status: Statuses.values.map((status) => status.displayName).toList().contains(task['properties']['Статус']['status']['name'] as String) ? Statuses.fromString(task['properties']['Статус']['status']['name'] as String) : null,
        );
      }).where((task) => (task.status != null)).toList();
      listOfTasks.sort((a, b) => (a.status as Statuses).index.compareTo((b.status as Statuses).index));
      return listOfTasks;
    } else {
      throw Exception();
    }
  }
  //TODO add write off time method
}