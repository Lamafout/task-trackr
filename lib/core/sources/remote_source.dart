import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_trackr/config/api_paths.dart';
import 'package:task_trackr/config/paths_to_pages.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';

class RemoteSource {
  final Dio dio;
  RemoteSource() : dio = Dio() {
    dio.interceptors.add(di<Interceptor>());
  }
  Future<List<Employee>> getEmployees() async {
    final response = await dio.post(databaseUrl(peopleDatabasePath));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.data);
      final List<Employee> listOfEmployees = data.map((employee) {
        return Employee(
          id: employee['Ссылка']['id'],
          name: employee['Имя']['title'][0]['content'],
          email: employee['Email']['email'],
          photo: employee['avatar_url'],
        );
      }).toList();
      return listOfEmployees;
    } else {
      throw InternetException();
    }
  }
  //TODO add get tasks method
  //TODO add write off time method
}