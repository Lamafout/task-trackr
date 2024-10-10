import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class WriteOffRepository {
  Future<Either<Failure, void>> writeOff(int time);
}