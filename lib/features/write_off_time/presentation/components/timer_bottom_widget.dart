import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';

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
    setState(() {
      seconds = newTime % 60;
      minutes = (newTime ~/ 60) % 60;
      hours = (newTime ~/ 3600) % 60;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO засунуть в блок билдер
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          // TODO replace with Theme
          style: const TextStyle(
            fontSize: 12
          ),
        ),
      ],
    );
  }
}