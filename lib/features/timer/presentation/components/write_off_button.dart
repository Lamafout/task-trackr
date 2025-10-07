import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/timer/index.dart';

class WriteOffButton extends StatelessWidget {
  final TaskClass task;
  final ValueNotifier<String> notifier;
  const WriteOffButton({
    super.key, 
    required this.task,
    required this.notifier
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      bloc: context.read<TimerBloc>(),
      listener: (context, state) {
        if (state.isWritedOffSuccess) {
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, child) {
            return Platform.isIOS
            ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: value.isEmpty
              ? () {}
              : () {
                context.read<TimerBloc>().writeOffTime(comment: notifier.value);
              },
              child: BlocBuilder<TimerBloc, TimerState>(
                bloc: context.read<TimerBloc>(),
                builder: (context, state) {
                  if (state.isWritedOffLoading) {
                    return Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          color: Theme.of(context).indicatorColor,
                        ));
                  } else {
                    if (state.isWritedOffSuccess) {
                      Navigator.pop(context);
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: value.isEmpty
                        ? Colors.white.withOpacity(0.05) 
                        : task.status!.color,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.pause_rounded,
                        size: 70,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    );
                  }
                }
              )
            )
            : MaterialButton(
              color: value.isEmpty
              ? Colors.white.withOpacity(0.05) 
              : task.status!.color,
              shape: const CircleBorder(),
              splashColor: value.isEmpty
              ? Colors.transparent
              : null,
              onPressed: value.isEmpty
              ? () {}
              : () {
                context.read<TimerBloc>().writeOffTime(comment: notifier.value);
                Navigator.pop(context);
              },
              child: BlocBuilder<TimerBloc, TimerState>(
                bloc: context.read<TimerBloc>(),
                builder: (context, state) {
                  if (state.isWritedOffLoading) {
                    return Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          color: Colors.black.withOpacity(0.8),
                        ));
                  } else {
                    if (state.isWritedOffSuccess) {
                      Navigator.pop(context);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.stop_rounded,
                        size: 70,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    );
                  }
                }
              )
            );
          }
        ),
      ),
    );
  }
}
