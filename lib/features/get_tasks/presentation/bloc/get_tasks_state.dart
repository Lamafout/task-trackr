part of 'get_tasks_bloc.dart';

@immutable
sealed class GetTasksState {}

final class GetTasksInitial extends GetTasksState {}

final class GetTasksLoading extends GetTasksState {}

class GotTasksState extends GetTasksState {
  final List<TaskClass> tasks;

  GotTasksState(this.tasks);
}

class FailureWhileGettingTasksState extends GetTasksState {
  final String errorMessage;

  FailureWhileGettingTasksState(this.errorMessage);
}
