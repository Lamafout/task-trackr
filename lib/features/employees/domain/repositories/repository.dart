import 'package:task_trackr/index.dart';

abstract class EmployeesRepository {
  Future<DataState<List<Employee>>> getEmployees();
}