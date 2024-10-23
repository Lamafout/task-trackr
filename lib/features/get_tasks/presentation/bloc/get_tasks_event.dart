part of 'get_tasks_bloc.dart';

@immutable
class GetTasksEvent {}

class GetTasksOfProjectsEvent extends GetTasksEvent {
  final String projectID;
  GetTasksOfProjectsEvent(this.projectID);
}

class QuitFromTasksScreenEvent extends GetTasksEvent {}