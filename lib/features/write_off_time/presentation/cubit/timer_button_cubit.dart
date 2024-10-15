import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/entities/task_class.dart';

part 'timer_button_state.dart';

class TimerButtonCubit extends Cubit<TimerButtonState> {
  TimerButtonCubit() : super(TimerButtonInitial());
  void startTimer(TaskClass task) {
    emit(TimerIsRunningState(task));
  }
  void pauseTimer() {
    emit(TimerIsPausedState((state as TimerIsRunningState).task));
  }
  void stopTimer() {
    emit(TimerButtonInitial());
  }
}
