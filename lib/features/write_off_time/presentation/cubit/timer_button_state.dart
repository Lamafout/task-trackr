part of 'timer_button_cubit.dart';

class TimerButtonState {}
class TimerButtonInitial extends TimerButtonState {}
class TimerIsWorksState extends TimerButtonState{
  final TaskClass task;
  final Duration time;
  TimerIsWorksState({required this.task, required this.time});
}
class TimerIsRunningState extends TimerIsWorksState {
  TimerIsRunningState({required super.task, required super.time});
}
class TimerIsPausedState extends TimerIsWorksState {
  TimerIsPausedState({required super.task, required super.time});
}
