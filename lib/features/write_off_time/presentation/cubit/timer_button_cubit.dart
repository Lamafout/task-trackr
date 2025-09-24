import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/cached_timer/presentation/bloc/cached_timer_bloc.dart';

part 'timer_button_state.dart';

class TimerButtonCubit extends Cubit<TimerButtonState> {
  TimerButtonCubit() : super(TimerButtonInitial());
  Timer? _timer;
  int _elapcedTime = 0;
  TaskClass? currentTask;
  void startTimer(TaskClass task) {
    _timer?.cancel();
    currentTask = task;
    emit(TimerIsRunningState(task: currentTask!, time: Duration(seconds: _elapcedTime)));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapcedTime++;
      emit(TimerIsRunningState(task: currentTask!, time: Duration(seconds: _elapcedTime)));
      di<CachedTimerBloc>().add(LoadStateToCacheEvent(TimerIsWorksState(task: currentTask!, time: Duration(seconds: _elapcedTime))));
    });
  }
  void pauseTimer() {
    _timer?.cancel();
    emit(TimerIsPausedState(task: currentTask!, time: Duration(seconds: _elapcedTime)));
  }
  void stopTimer() {
    currentTask = null;
    _timer?.cancel();
    _elapcedTime = 0;
    emit(TimerButtonInitial());
  }

  void setTimer(TimerIsPausedState state) {
    _timer?.cancel();
    _elapcedTime = state.time.inSeconds;
    currentTask = state.task;
    emit(TimerIsPausedState(task: currentTask!, time: Duration(seconds: _elapcedTime)));
  }
}
