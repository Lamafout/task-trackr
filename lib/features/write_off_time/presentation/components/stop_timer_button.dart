import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/write_off_page.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class StopTimerButton extends StatelessWidget {
  final TaskClass task;
  const StopTimerButton({
    super.key,
    required this.task,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      iconSize: 25,
      onPressed: () {
        di<TimerButtonCubit>().pauseTimer();
        Platform.isIOS
        ? showCupertinoModalPopup(
          context: context, 
          builder: (context) {
            return WriteOffPage(task: task);
          }
        )
        : showModalBottomSheet(
          isScrollControlled: true,
          context: context, 
          builder: (context) {
            return WriteOffPage(task: task);
          },
        );
      }, 
      icon: const Icon(
        Icons.stop_rounded,
      ),
    );
  }
}