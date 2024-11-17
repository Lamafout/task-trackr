import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/write_off_page.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TaskMaterial extends StatelessWidget {
  const TaskMaterial({super.key, required this.child, required this.task});
  final Widget child;
  final TaskClass task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di.get<TimerButtonCubit>(),
      builder: (context, state) {
        final bool isRunning = state is TimerIsRunningState && state.task.id == task.id;
        final bool isPaused = state is TimerIsPausedState && state.task.id == task.id; 
        final bool isAnyTaskRunning = state is TimerIsPausedState ||  state is TimerIsRunningState;
        return Material(
          color: state is TimerIsWorksState
          ? state.task.id == task.id
            ? task.status!.color
            : Platform.isIOS
              ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
              : Theme.of(context).cardColor
          : Platform.isIOS
            ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
            : Theme.of(context).cardColor,
          child: InkWell(
            splashColor: task.status!.color,
            onTap: isAnyTaskRunning
          ? isRunning
            ? () {
                Platform.isIOS
                ? showCupertinoModalBottomSheet(
                   context: context,
                   builder: (context) {
                     return WriteOffPage(task: task);
                   },
                )
                : showModalBottomSheet(
                   isScrollControlled: true,
                   context: context,
                   builder: (context) {
                     return WriteOffPage(task: task);
                   },
                );
              }
            : isPaused
              ? () {di<TimerButtonCubit>().startTimer(task); }
              : () {}
          : () {di<TimerButtonCubit>().startTimer(task); },
            // onTap: isAnyTaskRunning
            // ? isRunning
            //   ? () {di<TimerButtonCubit>().pauseTimer(); }
            //   : isPaused
            //     ? () {di<TimerButtonCubit>().startTimer(task); }
            //     : () {}
            // : () {di<TimerButtonCubit>().startTimer(task); },
            child: child
          ),
        );
      }
    );
  }
}