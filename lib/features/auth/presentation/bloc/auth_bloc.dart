import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/features/auth/domain/auth_use_case.dart';
import 'package:task_trackr/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<EnterIntoApplication>((event, emit) async {
      final useCase = di<AuthUseCase>();
      final result = await useCase.enterIntoApplication();

      if (result is DataSuccess) {
        emit(AuthenticationIsSuccessState(result.result!));
      } else {
        emit(AuthenticationIsFailureState(result.error.toString()));
      }
    });
  }
}