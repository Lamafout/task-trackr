part of 'auth_bloc.dart';

class AuthState {}
class AuthInitial extends AuthState {}
class AuthenticationIsSuccessState extends AuthState {
  final String id;
  AuthenticationIsSuccessState(this.id);
}
class AuthenticationIsFailureState extends AuthState {
  final String errorMessage;
  AuthenticationIsFailureState(this.errorMessage);
}