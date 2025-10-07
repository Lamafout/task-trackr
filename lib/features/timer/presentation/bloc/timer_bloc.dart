import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_trackr/features/timer/domain/index.dart';
import 'package:task_trackr/index.dart';

part 'timer_state.dart';

class TimerBloc extends Cubit<TimerState> {
  TimerBloc(this._service) : super(const TimerInitial()) {
    _service.getTimer().then((result) {
      if (result is DataSuccess) {
        emit(state.copyWith(initTime: Nullable(result.result?.startTime), task: Nullable(result.result?.task),));
        startTimer();
      }
    });
  }

  final TimerSerivce _service;
  Timer? _timer;

  Future<void> writeOffTime({String? comment}) async {
    final taskId = state.task?.id;
    final currentTime = state.currentTime;
    final initTime = state.initTime;

    if (!state.isStarted || currentTime == null || initTime == null || taskId == null) {
      return;
    }

    pauseTimer();
    await _service.writeOffTime(
      taskId: state.task?.id ?? '', 
      description: comment ?? state.comment ?? '', 
      duration: DateTime.parse(currentTime).difference(DateTime.parse(initTime)).inSeconds,
    ).then((result) {
      emit(state.copyWith(writeOffResult: result,));
      if (result is DataSuccess) {
        stopTimer();
      }

      if (result is DataFailure) {
        startTimer();
      }
    });
  }

  Future<void> startTimer({TaskClass? newTask}) async {
    final task = newTask ?? state.task;

    if (task != null) {
      final initTime = state.initTime ?? DateTime.now().toString();
      await _service.startTimer(task: task, startTime: initTime).then((result) {
        if (result is DataSuccess) {
          emit(state.copyWith(initTime: Nullable(result.result?.startTime), task: Nullable(result.result?.task), isPaused: false, currentTime: DateTime.now().toString()));
          _timer =  Timer.periodic(const Duration(seconds: 1), _timerTick);
        }
      });
    }
  }

  Future<void> stopTimer() async {
    final result = await _service.clearTimer();

    if (result is DataSuccess) {
      _timer?.cancel();
      emit(state.copyWith(isPaused: false, initTime: const Nullable(null), task: const Nullable(null)));
    }
  }

  Future<void> pauseTimer() async {
    final result = await _service.pauseTimer(pausedMoment: DateTime.now().toString());

    if (result is DataSuccess) {
      _timer?.cancel();
      emit(state.copyWith(isPaused: true,));
    }
  }

  void _timerTick(Timer timer) {
    print('tick');
    if (!state.isRunning || state.initTime == null) {
      print('${!state.isRunning}, ${state.initTime}');
      return;
    }

    final currentTime = DateTime.now();

    print('emitting: $currentTime,  ${state.initTime}, ');

    emit(state.copyWith(currentTime: currentTime.toString()));
  }
}