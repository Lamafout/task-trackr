part of 'get_projects_bloc.dart';

class GetProjectsState {}

class GetProjectsInitial extends GetProjectsState {}

class GotListOfProjectsState extends GetProjectsState {
  final List<Project> projects;
  GotListOfProjectsState({required this.projects});
}

class FailureWhileGettingProjectsState extends GetProjectsState {
  final String errorMessage;
  FailureWhileGettingProjectsState({required this.errorMessage});
}
