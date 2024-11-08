import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/cached_timer/presentation/bloc/cached_timer_bloc.dart';

part 'timer_button_state.dart';

class TimerButtonCubit extends Cubit<TimerButtonState> {
  TimerButtonCubit() : super(TimerButtonInitial());
  Timer? _timer;
  Duration _elapcedTime = const Duration(seconds: 0);
  TaskClass? currentTask;
  void startTimer(TaskClass task) {
    _timer?.cancel();
    currentTask = task;
    emit(TimerIsRunningState(task: currentTask!, time: _elapcedTime));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapcedTime += const Duration(seconds: 1);
      emit(TimerIsRunningState(task: currentTask!, time: _elapcedTime));
      di<CachedTimerBloc>().add(LoadStateToCacheEvent(TimerIsWorksState(task: currentTask!, time: _elapcedTime)));
    });
  }
  void pauseTimer() {
    _timer?.cancel();
    emit(TimerIsPausedState(task: currentTask!, time: _elapcedTime));
  }
  void stopTimer() {
    currentTask = null;
    _timer?.cancel();
    _elapcedTime = Duration.zero;
    emit(TimerButtonInitial());
  }

  void setTimer(TimerIsPausedState state) {
    _timer?.cancel();
    _elapcedTime = state.time;
    currentTask = state.task;
    emit(TimerIsPausedState(task: currentTask!, time: _elapcedTime));
  }
}
