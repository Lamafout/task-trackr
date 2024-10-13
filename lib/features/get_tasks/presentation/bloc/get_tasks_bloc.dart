import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/get_tasks/domain/get_tasks_usecase.dart';

part 'get_tasks_event.dart';
part 'get_tasks_state.dart';

class GetTasksBloc extends Bloc<GetTasksEvent, GetTasksState> {
  GetTasksBloc() : super(GetTasksInitial()) {
    on<GetTasksOfProjectsEvent>((event, emit) async {
      emit(GetTasksLoading());
      final useCase = di<GetTasksUseCase>();
      final result = await useCase.getTasksFromCache(event.projectID);
      result.fold(
        (failure) {
          emit(FailureWhileGettingTasksState(failure.message));
        }, 
        (list) {
          if (list.isNotEmpty) {
            emit(GotTasksState(list));
          }
        }
      );
     final fetchedResult = await useCase.getTasksFromAPI(event.projectID);
      fetchedResult.fold(
        (failure) {
          emit(FailureWhileGettingTasksState(failure.message));
        },
        (tasks) {
          emit(GotTasksState(tasks));
        }
      );
    });
  }
}
