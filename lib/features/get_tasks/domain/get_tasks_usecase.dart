import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/get_tasks/domain/get_tasks_repository.dart';

class GetTasksUseCase {
  final GetTasksRepository _getTasksRepository;

  GetTasksUseCase(this._getTasksRepository);

  Future<Either<Failure, List<TaskClass>>> getTasksFromAPI(String projectId) async {
    final result = await _getTasksRepository.fetchTasks(projectId);
    return result.fold(
      (failure) => Left(failure),
      (tasks) => Right(tasks),
    );
  }
  Future<Either<Failure, List<TaskClass>>> getTasksFromCache(String projectID) async {
    final result = await _getTasksRepository.getFromCache(projectID);
    return result.fold(
      (failure) => Left(failure),
      (tasks) => Right(tasks),
    );
  }
}