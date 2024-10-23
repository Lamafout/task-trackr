import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_button.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TaskWidget extends StatelessWidget {
  final TaskClass task;
  const TaskWidget({super.key, required this.task});
  _onTimerButtonTap() {
    var state = di<BottomWidgetBloc>().state;
    if (state is TaskIsRunningState) {
      di<BottomWidgetBloc>().add(PauseTaskEvent(task));
    } else {
      di<BottomWidgetBloc>().add(RunTaskEvent(task));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTimerButtonTap();
        if (di<TimerButtonCubit>().state is TimerIsRunningState && (di<TimerButtonCubit>().state as TimerIsRunningState).task == task) {
          di<TimerButtonCubit>().pauseTimer();
        } else {
          di<TimerButtonCubit>().startTimer(task);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: SmoothClipRRect(
          smoothness: 0.6, //iOS default
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Platform.isIOS
            ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
            : Theme.of(context).cardColor,
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimerButton(task: task, onTap: _onTimerButtonTap,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    task.title as String,
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}