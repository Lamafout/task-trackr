import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/write_off_page.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({
    super.key,
    required this.task,
    this.useTaskColor = true
  });

  final TaskClass task;
  final bool useTaskColor;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di<TimerButtonCubit>(),
      builder: (context, state) {
        final bool isRunning = state is TimerIsRunningState && state.task.id == task.id;
        final bool isPaused = state is TimerIsPausedState && state.task.id == task.id; 
        final bool isAnyTaskRunning = state is TimerIsPausedState ||  state is TimerIsRunningState;
        // TODO сделать айос кнопку
        return IconButton.filled(
          style: ButtonStyle(
            backgroundColor: useTaskColor
            ? const WidgetStatePropertyAll<Color>(Colors.transparent)
            : WidgetStatePropertyAll<Color>(Colors.blue.withOpacity(0.3)),
            fixedSize: useTaskColor
            ? null
            : const WidgetStatePropertyAll<Size>(Size(60, 60)),
            shape: useTaskColor
            ? null
            : const WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder()),
          ),
          iconSize: 35,
          onPressed: isAnyTaskRunning
          ? isRunning
            ? () {
                Platform.isIOS
                ? showCupertinoModalBottomSheet(
                  enableDrag: false,
                   context: context,
                   builder: (context) {
                     return WriteOffPage(task: task);
                   },
                )
                : showModalBottomSheet(
                   isScrollControlled: true,
                   enableDrag: false,
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
          icon: Icon(
            isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: useTaskColor
            ? isRunning || isPaused 
              ? task.status!.displayName == 'В работе'
                ? Colors.black
                : Theme.of(context).primaryTextTheme.displaySmall!.color
              : task.status!.color
            : null,
          ),
        );
      }
    );
  }
}