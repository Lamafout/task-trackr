import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

part 'running_timer_state_class.g.dart';

@HiveType(typeId: 4)
class RunningTimerState {
  @HiveField(0)
  final TaskClass task;
  @HiveField(1)
  final int time;

  RunningTimerState({
    required this.task,
    required this.time,
  });

  factory RunningTimerState.fromState(TimerIsWorksState state) {
    return RunningTimerState(task: state.task, time: state.time.inSeconds);
  }

  TimerIsPausedState toState() {
    return TimerIsPausedState(task: task, time: Duration(seconds:  time));
  }
}