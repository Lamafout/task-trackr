import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/core/sources/remote_source.dart';
import 'package:task_trackr/features/get_projects/domain/get_projects_repository.dart';

class GetProjectsRepositoryImpl implements GetProjectsRepository{
  final RemoteSource remoteSource;
  final LocalSource localSource;

  GetProjectsRepositoryImpl({required this.remoteSource, required this.localSource});

  @override
  Future<Either<Failure, List<Project>>> fetchProjects() async {
    try {
      final employeeID = localSource.getID();
      final result = await remoteSource.getProjects(employeeID);

      await localSource.saveProjects(result);

      return Right(result);
    } on Exception catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getFromCache() async {
    try {
      final result = await localSource.getProjects();
      return Right(result);
    } on Exception catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}