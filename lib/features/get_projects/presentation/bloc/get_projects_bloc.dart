import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/features/get_projects/domain/get_projects_use_case.dart';

part 'get_projects_event.dart';
part 'get_projects_state.dart';

class GetProjectsBloc extends Bloc<GetProjectsEvent, GetProjectsState> {
  GetProjectsBloc() : super(GetProjectsInitial()) {
    on<ShowListOfActiveProjectsEvent>((event, emit) async {
      print('событие дошло');
      final useCase = di<GetProjectsUseCase>();
      final result = await useCase.loadListOfProjects();
      result.fold(
        (failure) {
          emit(FailureWhileGettingProjectsState(errorMessage: failure.message));
          print('не успех');
        },
        (list) { 
          emit(GotListOfProjectsState(projects: list));
          print('успех');
        }
      );
    });
  }
}
