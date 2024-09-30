part of 'set_employee_bloc.dart';

class SetEmployeeState {}

class SetEmployeeInitial extends SetEmployeeState {}

class SettedState extends SetEmployeeState {}

class UnsettedState extends SetEmployeeState {}
class FailureWhileSettedState extends SetEmployeeState {
  final String errorMessage;
  FailureWhileSettedState(this.errorMessage);
}