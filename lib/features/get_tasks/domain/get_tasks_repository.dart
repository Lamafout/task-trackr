import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class GetTasksRepository {
  Future<Either<Failure, void>> fetchTasks(String projectID);
  Future<Either<Failure, List<TaskClass>>> getFromCache(String projectID);
}