part of 'bottom_widget_bloc.dart';

class BottomWidgetEvent {}

class RunTaskEvent extends BottomWidgetEvent {
  final TaskClass task;
  RunTaskEvent(this.task);
}

class PauseTaskEvent extends BottomWidgetEvent {
  final TaskClass task;
  PauseTaskEvent(this.task);
}

class StopTaskEvent extends BottomWidgetEvent {}
