import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/timer/index.dart';

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
    return BlocBuilder<TimerBloc, TimerState>(
      bloc: context.read<TimerBloc>(),
      builder: (context, state) {
        final bool isRunning = state.isRunning && state.task?.id == task.id;
        final bool isPaused = state.isPaused && state.task?.id == task.id; 
        final bool isAnyTaskRunning = state.isStarted;
        return IconButton.filled(
          style: ButtonStyle(
            backgroundColor: useTaskColor
            ? const WidgetStatePropertyAll<Color>(Colors.transparent)
            : WidgetStatePropertyAll<Color>(task.status!.color.withOpacity(0.3)),
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
                context.read<TimerBloc>().pauseTimer();
                Platform.isIOS
                ? showCupertinoModalBottomSheet(
                  enableDrag: false,
                   context: context,
                   builder: (_) {
                    return BlocProvider.value(
                      value: context.read<TimerBloc>(),
                      child: WriteOffPage(task: task),
                    );
                  },
                )
                : showModalBottomSheet(
                   isScrollControlled: true,
                   enableDrag: false,
                   context: context,
                   builder: (_) {
                    return BlocProvider.value(
                      value: context.read<TimerBloc>(),
                      child: WriteOffPage(task: task),
                    );
                  },
                );
              }
            : isPaused
              ? () {context.read<TimerBloc>().startTimer(newTask: task); }
              : () {}
          : () {context.read<TimerBloc>().startTimer(newTask: task); },
          icon: Icon(
            isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
            color: useTaskColor
            ? isRunning || isPaused 
              ? task.status!.displayName == 'В работе'
                ? Colors.black
                : Theme.of(context).primaryTextTheme.displaySmall!.color
              : task.status!.color
            : task.status!.color,
          ),
        );
      }
    );
  }
}