import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/core/sources/remote_source.dart';
import 'package:task_trackr/features/get_tasks/domain/get_tasks_repository.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final RemoteSource remoteSource;
  final LocalSource localSource;

  GetTasksRepositoryImpl({required this.remoteSource, required this.localSource});

  @override
  Future<Either<Failure, void>> fetchTasks(String projectID) async {
    final employeeID = localSource.getID();
    try {
      final result = await remoteSource.getTasks(employeeID:  employeeID, projectID:  projectID);
      for (var task in result) {
        task.projectID = projectID;
      }

      await localSource.saveTasks(result);

      return const Right(null);
    } on Exception catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskClass>>> getFromCache(String projectID) async {
    try {
      final result = await localSource.getTasks(projectID);
      return Right(result);
    } on Exception catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}