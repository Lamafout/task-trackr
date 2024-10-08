import 'package:flutter/material.dart';
import 'package:task_trackr/features/write_off_time/presentation/timer_button.dart';

class TimerIndicator extends StatefulWidget {
  const TimerIndicator({super.key});

  @override
  State<TimerIndicator> createState() => _TimerIndicatorState();
}

class _TimerIndicatorState extends State<TimerIndicator> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TimerButton(onTimeChanged: updateTime),
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