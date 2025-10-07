import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/timer/index.dart';

class TaskMaterial extends StatelessWidget {
  const TaskMaterial({super.key, required this.child, required this.task});
  final Widget child;
  final TaskClass task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      bloc: context.read<TimerBloc>(),
      builder: (context, state) {
        final bool isRunning = state.isRunning && state.task?.id == task.id;
        final bool isPaused = state.isPaused && state.task?.id == task.id;
        final bool isAnyTaskRunning = state.isStarted;
        return Material(
          color: state.task?.id == task.id
              ? task.status!.color
              : Theme.of(context).cardColor,
          child: InkWell(
            splashColor: task.status!.color,
            onTap: isAnyTaskRunning
                ? isRunning
                      ? () {
                          Platform.isIOS
                              ? showCupertinoModalBottomSheet(
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
                      ? () {
                          context.read<TimerBloc>().startTimer(newTask: task);
                        }
                      : () {}
                : () {
                    context.read<TimerBloc>().startTimer(newTask: task);
                  },
            child: child,
          ),
        );
      },
    );
  }
}
