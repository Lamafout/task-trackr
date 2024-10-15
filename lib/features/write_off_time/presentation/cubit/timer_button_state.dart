part of 'timer_button_cubit.dart';

class TimerButtonState {}
class TimerButtonInitial extends TimerButtonState {}
class TimerIsRunningState extends TimerButtonState {
  final TaskClass task;
  TimerIsRunningState(this.task);
}
class TimerIsPausedState extends TimerButtonState {
  final TaskClass task;
  TimerIsPausedState(this.task);
}
