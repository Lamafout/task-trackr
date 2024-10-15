part of 'bottom_widget_bloc.dart';

class BottomWidgetState {}

class BottomWidgetInitial extends BottomWidgetState {}

class TaskIsRunningState extends BottomWidgetState {
  final Duration time;
  final TaskClass task;
  TaskIsRunningState({required this.time, required this.task});
}

class TaskIsPausedState extends BottomWidgetState {
  final Duration time;
  final TaskClass task;
  TaskIsPausedState({required this.time, required this.task});
}
