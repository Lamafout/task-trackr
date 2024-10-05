import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class GetProjectsRepository {
  Future<Either<Failure, List<Project>>> getProjects();
}