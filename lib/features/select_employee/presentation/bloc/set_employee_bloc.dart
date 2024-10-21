import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/features/select_employee/domain/select_employee_use_case.dart';
part 'set_employee_event.dart';
part 'set_employee_state.dart';

class  SetEmployeeBloc extends Bloc<SetEmployeeEvent, SetEmployeeState> {
  SetEmployeeBloc() : super(SetEmployeeInitial()) {
    on<SubmitEmployee>((event, emit) async {
      final useCase = di<SelectEmployeeUseCase>();
      final result = await useCase.tapOnSubmitEployeeButton(event.employee);
      result.fold(
        (failure) => emit(FailureWhileSettedState(failure.message)),
        (status) {
          if (status) {
            emit(SettedState());
          } else {
            emit(UnsettedState());
          }
        }
      );
    });
  }
}
