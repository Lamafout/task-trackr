import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/entities/task_class.dart';

part 'timer_button_state.dart';

class TimerButtonCubit extends Cubit<TimerButtonState> {
  TimerButtonCubit() : super(TimerButtonInitial());
  TaskClass? currentTask;
  void startTimer(TaskClass task) {
    currentTask = task;
    emit(TimerIsRunningState(currentTask!));
  }
  void pauseTimer() {
    emit(TimerIsPausedState(currentTask!));
  }
  void stopTimer() {
    currentTask = null;
    emit(TimerButtonInitial());
  }
}
