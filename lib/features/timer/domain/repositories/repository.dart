import 'package:task_trackr/index.dart';

abstract class TimerRepository {
  Future<DataState<void>> writeOffTime(TimeRequest request);
  Future<DataState<void>> setTimer({required TaskClass task, required String startTime, String? pausedTime});
  Future<DataState<StartedTimer>> getTimer();
  Future<DataState<void>> clearTimer();
}