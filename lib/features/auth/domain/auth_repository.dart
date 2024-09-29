import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> getUserID();
}