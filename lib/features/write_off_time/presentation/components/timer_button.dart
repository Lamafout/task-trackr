import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({
    super.key,
    required this.task,
  });
  final TaskClass task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di<TimerButtonCubit>(),
      builder: (context, state) {
        final bool isRunning = state is TimerIsRunningState && state.task.id == task.id;
        final bool isPaused = state is TimerIsPausedState && state.task.id == task.id; 
        final bool isAnyTaskRunning = state is TimerIsPausedState ||  state is TimerIsRunningState;
        return IconButton(
          iconSize: 35,
          onPressed: isAnyTaskRunning
          ? isRunning
            ? () {di<TimerButtonCubit>().pauseTimer(); }
            : isPaused
              ? () {di<TimerButtonCubit>().startTimer(task); }
              : null
          : () {di<TimerButtonCubit>().startTimer(task); },
          icon: Icon(
            isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
          ),
        );
      }
    );
  }
}