import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/stop_timer_button.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_button.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class TimerBottomWidget extends StatefulWidget {
  const TimerBottomWidget({super.key});

  @override
  State<TimerBottomWidget> createState() => _TimerBottomWidgetState();
}

class _TimerBottomWidgetState extends State<TimerBottomWidget> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  updateTime(int newTime) {
    seconds = newTime % 60;
    minutes = (newTime ~/ 60) % 60;
    hours = (newTime ~/ 3600) % 60;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di<TimerButtonCubit>(),
      builder: (context, state) {
        if (state is TimerButtonInitial) {
          return Container(height: 0,);
        } else {
          updateTime((state as TimerIsWorksState).time.inSeconds);
          return ClipRRect(
            child: Container(
              height: 70,
              color: Platform.isIOS
              ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor!.withOpacity(0.8) 
              : Theme.of(context).cardColor.withOpacity(0.8),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 5,),
                child: Row(
                  children: [
                    TimerButton(task: state.task, useTaskColor: false,),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: StopTimerButton(task: state.task,),
                    ),
                    Expanded(
                      child: Text(
                        state.task.title!,
                        style: Platform.isIOS
                        ? Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontFamily: 'San-Francisco') 
                        : Theme.of(context).primaryTextTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 13),
                      child: Text(
                        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: Platform.isIOS
                        ? Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco',)
                        : Theme.of(context).primaryTextTheme.titleMedium!.copyWith()                    
                      ),
                    ),
                  ],  
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
