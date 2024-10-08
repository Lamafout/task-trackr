part of 'get_tasks_bloc.dart';

@immutable
sealed class GetTasksEvent {}

class GetTasksOfProjectsEvent extends GetTasksEvent {
  final String projectID;
  GetTasksOfProjectsEvent(this.projectID);
}