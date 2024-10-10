part of 'get_tasks_bloc.dart';

@immutable
class GetTasksState {}

class GetTasksInitial extends GetTasksState {}

class GetTasksLoading extends GetTasksState {}

class GotTasksState extends GetTasksState {
  final List<TaskClass> tasks;

  GotTasksState(this.tasks);
}

class FailureWhileGettingTasksState extends GetTasksState {
  final String errorMessage;

  FailureWhileGettingTasksState(this.errorMessage);
}
