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

  Future<DataState<void>> startTimer({
    required TaskClass task,
    required String startTime,
  }) async {
    return await _timerRepository.startTimer(task: task, startTime: startTime);
  }

  Future<DataState<StartedTimer>> getTimer() async {
    return await _timerRepository.getTimer();
  }

  Future<DataState<void>> clearTimer() async {
    return await _timerRepository.clearTimer();
  }
}