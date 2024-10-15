import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class StopTimerButton extends StatelessWidget {
  const StopTimerButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.amber),
      ),
      iconSize: 25,
      onPressed: () {
        di<BottomWidgetBloc>().add(StopTaskEvent());
        di<TimerButtonCubit>().stopTimer();
      }, 
      icon: const Icon(
        Icons.stop_rounded,
        color: Colors.white,
      ),
    );
  }
}