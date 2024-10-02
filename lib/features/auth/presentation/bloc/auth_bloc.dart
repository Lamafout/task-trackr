import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/auth/domain/auth_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<EnterIntoApplication>((event, emit) async {
      final useCase = di<AuthUseCase>();
      final result = await useCase.enterIntoApplication();
      result.fold(
        //TODO сделать обработку разных ошибок
        (failure) {emit(AuthenticationIsFailureState(failure.toString())); print('не прошло');},
        (id) {emit(AuthenticationIsSuccessState(id)); print('прошло');}, 
      );
    });
  }
}