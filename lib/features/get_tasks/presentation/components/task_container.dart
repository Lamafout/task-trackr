import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({super.key, required this.child, required this.task});
  final Widget child;
  final TaskClass task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di.get<TimerButtonCubit>(),
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
          width: MediaQuery.of(context).size.width * 0.9,
          color: state is TimerIsWorksState
          ? state.task.id == task.id
            ? task.status!.color
            : Platform.isIOS
              ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
              : Theme.of(context).cardColor
          : Platform.isIOS
            ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
            : Theme.of(context).cardColor,
          child: child,
        );
      }
    );
  }
}