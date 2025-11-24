import 'package:task_trackr/index.dart';

abstract class RestRemoteSource {

  Future<DataState<List<EmployeeDTO>>> getEmployees();

  Future<DataState<List<Project>>> getProjects(String employeeID);

  Future<DataState<List<TaskClass>>> getTasks({required String employeeID, required String projectID});
  
  Future<DataState<void>> writeOffTime(TimeRequest request);
}