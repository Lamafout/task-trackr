import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/features/get_employees/domain/get_employees_use_case.dart';
part 'get_employees_event.dart';
part 'get_employees_state.dart';

class GetEmployeesBloc extends Bloc<GetEmployeesEvent, GetEmployeesState> {
  GetEmployeesBloc() : super(GetEmployeesInitial()) {
    on<GetListOfEmployees>((event, emit) async {
      emit(LoadingListOfEmployeesState());
      final useCase = di<GetEmployeesUseCase>();
      final result = await useCase.showListOfEmployees();
      result.fold(
        (failure) => emit(FailureWhileLoadedListOfEmployeesState(failure.message)),
        (list) => emit(LoadedListOfEmployeesState(list)),
      );
    });
  }
}
