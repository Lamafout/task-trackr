import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/timer/index.dart';

class StopTimerButton extends StatelessWidget {
  final TaskClass task;
  const StopTimerButton({
    super.key,
    required this.task,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 35,
      onPressed: () {
        context.read<TimerBloc>().stopTimer();
        Platform.isIOS
        ? showCupertinoModalBottomSheet(
          context: context, 
          builder: (_) {
            return BlocProvider.value(
              value: context.read<TimerBloc>(),
              child: WriteOffPage(task: task),
            );
          }
        )
        : showModalBottomSheet(
          isScrollControlled: true,
          context: context, 
          builder: (_) {
            return BlocProvider.value(
              value: context.read<TimerBloc>(),
              child: WriteOffPage(task: task),
            );
          }
        );
      }, 
      icon: const Icon(
        Icons.stop_rounded,
      ),
    );
  }
}