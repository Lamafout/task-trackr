import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/task_container.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_button.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TaskWidget extends StatelessWidget {
  final TaskClass task;
  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: SmoothClipRRect(
        smoothness: 0.6,
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: task.status!.color,
            onTap: () {
              if (di<TimerButtonCubit>().state is TimerIsRunningState && (di<TimerButtonCubit>().state as TimerIsRunningState).task == task) {
                di<TimerButtonCubit>().pauseTimer();
              } else {
                di<TimerButtonCubit>().startTimer(task);
              }
            },
            child: TaskContainer(
              task: task,
              child: Row(
                children: [
                  TimerButton(task: task),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      task.title as String,
                      style: Platform.isIOS 
                      ? Theme.of(context).primaryTextTheme.labelLarge!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.w600)
                      : Theme.of(context).primaryTextTheme.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}