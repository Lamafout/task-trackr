import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/auth/domain/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _repository;
  AuthUseCase(this._repository);

  Future<Either<Failure, String>> enterIntoApplication() async {
    final response = await _repository.getUserID();
    return response.fold(
      (failure) => Left(failure),
      (id) => Right(id),
    );
  }
}