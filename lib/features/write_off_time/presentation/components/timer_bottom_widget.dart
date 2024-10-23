import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/stop_timer_button.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_button.dart';

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
  // TODO рефакторинг, а то говнокода и легаси многовато
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: di<BottomWidgetBloc>(),
      builder: (context, state) {
        if (state is TaskIsRunningState) {
        updateTime(state.time.inSeconds);
          return Material(
            color: Colors.transparent,
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ]
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black87,
                    ),
                    child: Text(
                      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                      // TODO replace with theme
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )
                    ),
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
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    child: TimerButton(task: state.task, onTap: () {
                        var stateForButton = di<BottomWidgetBloc>().state;
                        if (stateForButton is TaskIsRunningState) {
                          di<BottomWidgetBloc>().add(PauseTaskEvent(state.task));
                        } else {
                          di<BottomWidgetBloc>().add(RunTaskEvent(state.task));
                        }
                      },
                    ),
                  ),
                  StopTimerButton(task: state.task,),
                ],  
              ),
            ),
          );
        } else  if (state is TaskIsPausedState) {
        updateTime(state.time.inSeconds);
          return Material(
            color: Colors.transparent,
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                color: Platform.isIOS
                ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor 
                : Theme.of(context).cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.5,
                    blurRadius: 5,
                  )
                ]
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black87,
                    ),
                    child: Text(
                      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.task.title!,
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    child: TimerButton(task: state.task, onTap: () {
                        var stateForButton = di<BottomWidgetBloc>().state;
                        if (stateForButton is TaskIsRunningState) {
                          di<BottomWidgetBloc>().add(PauseTaskEvent(state.task));
                        } else {
                          di<BottomWidgetBloc>().add(RunTaskEvent(state.task));
                        }
                      },
                    ),
                  ),
                  StopTimerButton(task: state.task),
                ],  
              ),
            ),
          );
        } else {
          return Container(height: 0,);
        }
      },
    );
  }
}
