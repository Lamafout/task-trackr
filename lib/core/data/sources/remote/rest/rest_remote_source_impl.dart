import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:task_trackr/index.dart';

class TaskTrackerRestSource extends RestClient implements RestRemoteSource {
  TaskTrackerRestSource(super.dio);

  CancelToken? _cancelToken;
  void _cancelRequest() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel();
    }
  }

  @override
  Future<DataState<List<EmployeeDTO>>> getEmployees() {
    return execute(dio.get(getEmployeesPath))
        .then((response) {
          final List<dynamic> data = jsonDecode(response.data);
          return data.map((employee) {
            return EmployeeDTO(
              id: employee['id'] as String?,
              name: employee['username'] as String,
              email: employee['email'] as String?,
              photo: employee['icon'] != '' ? employee['icon'] as String? : null,
            );
          }).toList();
        })
        .toDataState();
  }

  @override
  Future<DataState<List<Project>>> getProjects(String employeeID) {
    return execute(dio.get('$getProjectsPath$employeeID'))
        .then((response) {
          final List<dynamic> data = jsonDecode(response.data);
          return data.map((project) {
            return Project(
              id: project['id'],
              icon: project['icon'] != '' ? project['icon'] : null,
              name: project['name'],
              status: ProjectStatuses.isCorrectStatus(project['status']) ? ProjectStatuses.fromString(project['status'] as String) : null,
            );
          }).where((project) => (project.status != null)).toList();
        })
        .toDataState();
  }

  @override
  Future<DataState<List<TaskClass>>> getTasks({required String employeeID, required String projectID}) {
    _cancelRequest();
    _cancelToken = CancelToken();
    
    return execute(
      dio.get(
        setDataToGetTasks(employeeID, projectID),
        cancelToken: _cancelToken,
      ),
    )
        .then((response) {
          final List<dynamic> data = jsonDecode(response.data) ?? [];
          return data.map((task) {
            return TaskClass(
              id: task['id'],
              title: task['title'],
              status: TaskStatuses.values.map((status) => status.displayName).toList().contains(task['status']) ? TaskStatuses.fromString(task['status'] as String) : null,
            );
          }).where((task) => (task.status != null)).toList();
        })
        .toDataState();
  }

  @override
  Future<DataState<void>> writeOffTime(TimeRequest request) async {
    return execute(
      dio.post(
        writeTimePath,
        data: request.toJSON()
      )
    ).toDataState();
  }
}