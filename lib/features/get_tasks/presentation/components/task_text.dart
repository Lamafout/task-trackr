import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/timer/index.dart';

class TaskText extends StatelessWidget {
  const TaskText({
    super.key,
    required this.task,  
  });
  final TaskClass task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      bloc: context.read<TimerBloc>(),
      builder: (context, state) {
        final bool isRunning = state.isRunning && state.task?.id == task.id;
        final bool isPaused = state.isPaused && state.task?.id == task.id; 
        final color = task.status!.displayName == 'В работе'
        ? isRunning || isPaused
          ? Colors.black
          : null
        : null;
        return Text(
          task.title as String,
          style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: color, fontWeight: FontWeight.w600),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}