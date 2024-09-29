import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalSource _localSource;
  AuthRepositoryImpl(this._localSource);

  @override
  Future<Either<Failure, String>> getUserID() async {
    try {
      final id = _localSource.getID();
      return Right(id);
    } on NoIDException catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}