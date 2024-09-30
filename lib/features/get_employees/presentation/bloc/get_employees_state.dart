part of 'get_employees_bloc.dart';

class GetEmployeesState {}

class GetEmployeesInitial extends GetEmployeesState {}

class LoadingListOfEmployeesState extends GetEmployeesState {}

class LoadedListOfEmployeesState extends GetEmployeesState {
  final List<Employee> employees;
  LoadedListOfEmployeesState(this.employees);
}

class FailureWhileLoadedListOfEmployeesState extends GetEmployeesState {
  final String errorMessage;
  FailureWhileLoadedListOfEmployeesState(this.errorMessage);
}
