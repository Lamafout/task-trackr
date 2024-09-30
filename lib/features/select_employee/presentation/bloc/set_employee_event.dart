part of 'set_employee_bloc.dart';

class SetEmployeeEvent {}

class SubmitEmployee extends SetEmployeeEvent {
  final Employee employee;
  SubmitEmployee(this.employee);
}
