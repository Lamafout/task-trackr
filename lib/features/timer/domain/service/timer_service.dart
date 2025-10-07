import 'package:task_trackr/core/index.dart';
import 'package:task_trackr/features/auth/index.dart';
import 'package:task_trackr/features/timer/domain/index.dart';

class TimerSerivce {
  TimerSerivce({
    required AuthRepository authRepository,
    required TimerRepository timerRepository,
  }) : _timerRepository = timerRepository,
    _authRepository = authRepository;

  final TimerRepository _timerRepository;
  final AuthRepository _authRepository;

  Future<DataState<void>> writeOffTime({required String description, required int duration, required String taskId}) async {
    // 1. We need to get user`s ID for write off time request
    final userId = await _authRepository.getUserID();

    // 2. Exit if user ID doesn`t exist
    if (userId is DataFailure) {
      return userId;
    }

    // 3. Call write off time request with user ID
    return await _timerRepository.writeOffTime(TimeRequest(
      taskID: taskId, 
      description: description, 
      duration: duration, 
      employeeID: userId.result!
    ));
  }

  Future<DataState<StartedTimer>> startTimer({
    required TaskClass task,
    required String startTime,
  }) async {
    // 1. Checking if timer was paused
    bool hasPaused = false;

    final getResult = await _timerRepository.getTimer();

    if (getResult is DataSuccess && getResult.result?.pausedTime != null) {
      hasPaused = true;
    }

    // 2. Adding difference to initial start time to get corrected start time
    String? newStartTime;
    if (hasPaused) {
      newStartTime = DateTime.parse(startTime).add(DateTime.now().difference(
        DateTime.parse(getResult.result!.pausedTime!),
      )).toString();
    }

    final setResult = await _timerRepository.setTimer(
      task: task, 
      startTime: newStartTime ?? startTime
    );

    if (setResult is DataFailure) {
      return DataSuccess(result: StartedTimer(task: task, startTime: hasPaused ? newStartTime.toString() : startTime));
    }

    // 3. Getting actual state
    return await _timerRepository.getTimer();
  }

  Future<DataState<StartedTimer>> getTimer() async {
    return await _timerRepository.getTimer();
  }

  Future<DataState<void>> clearTimer() async {
    return await _timerRepository.clearTimer();
  }

  Future<DataState<void>> pauseTimer({required String pausedMoment}) async {
    // 1. Getting current timer for change pause state
    final getResult = await _timerRepository.getTimer();

    if (getResult is DataFailure) {
      return getResult;
    }

    // 2. Setting new properties of timer and return result
    return await _timerRepository.setTimer(task: getResult.result!.task, startTime: getResult.result!.startTime, pausedTime: pausedMoment);
  }
}