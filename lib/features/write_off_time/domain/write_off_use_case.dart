import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/write_off_time/domain/write_off_repository.dart';

class WriteOffUseCase {
  final WriteOffRepository _writeOffRepository;

  WriteOffUseCase(this._writeOffRepository);

  Future<Either<Failure, void>> tapOnTimerButton({required int time, required String comment, required String taskID}) async {
    final result = await _writeOffRepository.writeOff(time: time, comment: comment, taskID: taskID);
    return result.fold(
      (failure) => Left(failure),
      (status) => Right(status),
    );
  }
}