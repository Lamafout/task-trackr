import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_button.dart';

class TaskWidget extends StatelessWidget {
  final TaskClass task;
  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ClipRRect(
        // TODO replace with Theme's radius
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Platform.isIOS
          ? Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
          : Theme.of(context).cardColor,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimerButton(task: task),
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
    );
  }
}