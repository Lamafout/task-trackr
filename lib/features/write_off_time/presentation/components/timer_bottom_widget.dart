import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
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
  

  @override
  Widget build(BuildContext context) {
    // TODO засунуть в блок билдер
    return BlocBuilder(
      bloc: di<BottomWidgetBloc>(),
      builder: (context, state) {
        if (state is TaskIsRunningState) {
        print('current state is $state');
        updateTime(state.time.inSeconds);
          return Material(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
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
                        fontSize: 14,
                      )
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.task.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    child: TimerButton(
                      isRunning: true,
                      onTap: () {
                        di<BottomWidgetBloc>().add(PauseTaskEvent(state.task));
                      },
                    ),
                  ),
                  IconButton.filled(
                    iconSize: 30,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amber),
                    ),
                    onPressed: () {
                      di<BottomWidgetBloc>().add(StopTaskEvent(state.task));
                    }, 
                    icon: const Icon(Icons.stop_rounded)
                  )
                ],  
              ),
            ),
          );
        } else  if (state is TaskIsPausedState) {
          print('current state is $state');
        updateTime(state.time.inSeconds);
          return Material(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
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
                        fontSize: 14,
                      )
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.task.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    child: TimerButton(
                      isRunning: false,
                      onTap: () {
                        di<BottomWidgetBloc>().add(RunTaskEvent(state.task));
                      },
                    ),
                  ),
                  IconButton.filled(
                    iconSize: 30,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amber),
                    ),
                    onPressed: () {
                      di<BottomWidgetBloc>().add(StopTaskEvent(state.task));
                    }, 
                    icon: const Icon(Icons.stop_rounded)
                  )
                ],  
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}