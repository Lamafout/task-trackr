import 'package:task_trackr/core/index.dart';
import 'package:task_trackr/features/timer/index.dart';

class TimerRepositoryImpl implements TimerRepository {
  TimerRepositoryImpl({
    required this.localSource,
    required this.remoteSource
  });

  final LocalSource localSource;
  final RemoteSource remoteSource;

  @override
  Future<DataState<void>> clearTimer() async {
    try {
      await localSource.clearTimer();
      return DataSuccess(result: null);
    } on Exception catch(e) {
      return DataFailure(error: Failure(e.toString()));
    }
  }

  @override
  Future<DataState<StartedTimer>> getTimer() async {
    try {
      final result = await localSource.getTimer();
      return DataSuccess(result: result);
    } on Exception catch(e) {
      return DataFailure(error: Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> startTimer({required TaskClass task, required String startTime}) async {
    try {
      await localSource.saveTimer(task: task, startTime: startTime);
      return DataSuccess(result: null);
    } on Exception catch(e) {
      return DataFailure(error: Failure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> writeOffTime(TimeRequest request) async {
    try {
      final result = await remoteSource.writeOffTime(request);
      return DataSuccess(result: result);
    } on Exception catch(e) {
      return DataFailure(error: Failure(e.toString()));
    }
  }
}