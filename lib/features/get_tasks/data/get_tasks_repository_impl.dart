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
  Future<Either<Failure, List<TaskClass>>> getTasks(String projectID) async {
    final employeeID = localSource.getID();
    try {
      final result = await remoteSource.getTasks(employeeID:  employeeID, projectID:  projectID);
      return Right(result);
    } on Exception catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}