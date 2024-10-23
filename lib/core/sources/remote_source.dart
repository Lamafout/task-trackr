import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_trackr/config/paths_to_pages.dart';
import 'package:task_trackr/config/statuses.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/entities/time_request.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';
import 'package:task_trackr/core/interceptors/header_interceptor.dart';

class RemoteSource {
  final Dio dio;
  RemoteSource() : dio = Dio() {
    dio.interceptors.add(di<HeaderInterceptor>());
  }
  CancelToken? _cancelToken;
  void _cancelRequest() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel();
    }
  }


  Future<List<Employee>> getEmployees() async {
    final response = await dio.get(getEmployeesPath);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);
      final List<Employee> listOfEmployees = data.map((employee) {
        return Employee(
          id: employee['id'] as String?,
          name: employee['username'] as String,
          email: employee['email'] as String?,
          photo: employee['icon'] != '' ? employee['icon'] as String? : null,
        );
      }).toList();
      return listOfEmployees;
    } else {
      throw InternetException();
    }
  }

  Future<List<Project>> getProjects(employeeID) async {
   final response = await dio.get('$getProjectsPath$employeeID');
   
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);
      final List<Project> listOfProjects = data.map((project) {        
        return Project(
          id: project['id'],
          icon: project['icon'] != '' ? project['icon'] : null,
          name: project['name'],
          // TODO remove
          picture: null,
        );
      }).toList();

      return listOfProjects;
    } else {
      throw Exception();
    }
  }

  Future<List<TaskClass>> getTasks({required String employeeID, required String projectID}) async {
    _cancelRequest();
    _cancelToken = CancelToken();
    final response = await dio.get(
      setDataToGetTasks(employeeID, projectID),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data) ?? [];
      final List<TaskClass> listOfTasks = data.map((task) {
        return TaskClass(
          id: task['id'],
          title: task['title'],
          status: Statuses.values.map((status) => status.displayName).toList().contains(task['status']) ? Statuses.fromString(task['status'] as String) : null,
        );
      }).where((task) => (task.status != null)).toList();
      listOfTasks.sort((a, b) => (a.status as Statuses).index.compareTo((b.status as Statuses).index));
      return listOfTasks;
    } else {
      throw Exception();
    }
  }
  
  Future<void> writeOffTime(TimeRequest request) async {
    final response = await dio.post(
      writeTimePath,
      data: request.toJSON()
    );

    if (response.statusCode == 201) {
      print('NEW LINE INTO TIME TABLE IS CREATED');
    }

    if (response.statusCode == 400) {
      throw DioException.badResponse(statusCode: response.statusCode!, requestOptions: response.requestOptions, response: response);
    } else if (response.statusCode == 500) {
      throw Exception();
    }
  }
}