import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class GetTasksRepository {
  Future<Either<Failure, List<TaskClass>>> getTasks(String projectID);
}