import 'package:flutter/material.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/task_material.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/task_text.dart';
import 'package:task_trackr/features/timer/presentation/components/timer_button.dart';

class TaskWidget extends StatelessWidget {
  final TaskClass task;
  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TaskMaterial(
          task: task,
          child: Container(
            padding: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                TimerButton(task: task),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TaskText(task: task)
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}