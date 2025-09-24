import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/write_off_time/domain/write_off_use_case.dart';

part 'timer_state.dart';

class TimerBloc extends Cubit<TimerState> {
  TimerBloc() : super(const TimerInitial());
  Timer? _timer;

  Future<void> writeOffTime() async {
    final taskId = state.task?.id;
    final currentTime = state.currentTime;
    final initTime = state.initTime;

    if (!state.isStarted || currentTime == null || initTime == null || taskId == null) {
      return;
    }

    stopTimer();
    await di<WriteOffUseCase>().tapOnTimerButton(
      time: DateTime.parse(currentTime).difference(DateTime.parse(initTime)).inSeconds, 
      comment: state.comment ?? '', 
      taskID: taskId
    ).then((result) {
      emit(state.copyWith(writeOffResult: result));

      if (result.isLeft()) {
        startTimer();
      }
    });
  }

  void startTimer() {
    _timer =  Timer.periodic(const Duration(seconds: 1), timerTick);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void timerTick(Timer timer) {
    if (!state.isRunning || state.currentTime == null || state.initTime == null) {
      return;
    }

    final currentTime = DateTime.now();

    emit(state.copyWith(currentTime: currentTime.toString()));
  }
}