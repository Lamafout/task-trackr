import 'package:dio/dio.dart';
import 'package:task_trackr/config/api_paths.dart';
import 'package:task_trackr/config/paths_to_pages.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
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
          id: employee['properties']['Ссылка']['id'] as String?,
          name: employee['properties']['Имя']['title'][0]['text']['content'] as String?,
          email: employee['properties']['Email']['email'] as String?,
          photo: employee['properties']['Ссылка']['people'][0]['avatar_url'] as String?,
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