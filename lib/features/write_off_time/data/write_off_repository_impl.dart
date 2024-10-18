import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/time_request.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/core/sources/remote_source.dart';
import 'package:task_trackr/features/write_off_time/domain/write_off_repository.dart';

class WriteOffRepositoryImpl implements WriteOffRepository {
  final RemoteSource remoteSource;
  final LocalSource localSource;

  WriteOffRepositoryImpl(this.remoteSource, this.localSource);
  @override
  Future<Either<Failure, void>> writeOff({required int time, required String comment, required String taskID}) async {
    final employeeID = localSource.getID();
    final request = TimeRequest(taskID: taskID, desciption: comment, duration: time, employeeID: employeeID);
    try {
      await remoteSource.writeOffTime(request);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}