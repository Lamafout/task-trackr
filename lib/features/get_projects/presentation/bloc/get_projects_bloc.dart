import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/features/get_projects/domain/get_projects_use_case.dart';

part 'get_projects_event.dart';
part 'get_projects_state.dart';

class GetProjectsBloc extends Bloc<GetProjectsEvent, GetProjectsState> {
  GetProjectsBloc() : super(GetProjectsInitial()) {
    on<ShowListOfActiveProjectsEvent>((event, emit) async {
      final useCase = di<GetProjectsUseCase>();

      final listFromCache = await useCase.getProjectsFromCash();
      listFromCache.fold(
        (failure) => emit(FailureWhileGettingProjectsState(errorMessage: failure.message)),
        (projects) => emit(GotListOfProjectsState(projects: projects))
      );

      final listFromAPI = await useCase.fetchProjects();
      await listFromAPI.fold(
        (failure) {
          if (!emit.isDone) {
            emit(FailureWhileGettingProjectsState(errorMessage: failure.message));
          }
        },
        (projects) async {
          final cachedResult = await useCase.getProjectsFromCash();
          cachedResult.fold(
            (failure) {
              if (!emit.isDone) {
                emit(FailureWhileGettingProjectsState(errorMessage: failure.message));
              }
            },
            (cachedProjects) {
              if (!emit.isDone) {
                emit(GotListOfProjectsState(projects: cachedProjects));
              }
            }
          );
        }
      );
    });
  }
}

