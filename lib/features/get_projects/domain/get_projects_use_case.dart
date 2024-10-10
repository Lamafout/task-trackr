import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/get_projects/domain/get_projects_repository.dart';

class GetProjectsUseCase {
  final GetProjectsRepository _getProjectsRepository;

  GetProjectsUseCase(this._getProjectsRepository);

  Future<Either<Failure, List<Project>>> fetchProjects() async {
    final result = await _getProjectsRepository.fetchProjects();
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  Future<Either<Failure, List<Project>>> getProjectsFromCash() async {
    final result = await _getProjectsRepository.getFromCache();
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }
}