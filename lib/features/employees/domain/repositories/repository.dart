import 'package:task_trackr/index.dart';

abstract class EmployeesRepository {
  Future<DataState<void>> setEmployee(SetEmpoyeeRequest request);
  Future<DataState<List<Employee>>> getEmployees();
}