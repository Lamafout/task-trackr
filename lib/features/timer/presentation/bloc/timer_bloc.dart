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
        emit(state.copyWith(initTime: result.result?.startTime, task: result.result?.task,));
      }
    });
  }

  final TimerSerivce _service;
  Timer? _timer;

  Future<void> writeOffTime() async {
    final taskId = state.task?.id;
    final currentTime = state.currentTime;
    final initTime = state.initTime;

    if (!state.isStarted || currentTime == null || initTime == null || taskId == null) {
      return;
    }

    stopTimer();
    await _service.writeOffTime(
      taskId: state.task?.id ?? '', 
      description: state.comment ?? '', 
      duration: DateTime.parse(currentTime).difference(DateTime.parse(initTime)).inSeconds,
    ).then((result) {
      emit(state.copyWith(writeOffResult: result));

      if (result is Failure) {
        startTimer();
      }
    });
  }

  Future<void> startTimer({TaskClass? newTask}) async {
    final task = newTask ?? state.task;

    if (task != null) {
      await _service.startTimer(task: task, startTime: state.initTime ?? DateTime.now().toString()).then((result) {
        if (result is DataSuccess) _timer =  Timer.periodic(const Duration(seconds: 1), _timerTick);
      });
    }
  }

  Future<void> stopTimer() async {
    final result = await _service.clearTimer();

    if (result is DataSuccess) {
      _timer?.cancel();
    }
  }

  void _timerTick(Timer timer) {
    if (!state.isRunning || state.currentTime == null || state.initTime == null) {
      return;
    }

    final currentTime = DateTime.now();

    emit(state.copyWith(currentTime: currentTime.toString()));
  }
}