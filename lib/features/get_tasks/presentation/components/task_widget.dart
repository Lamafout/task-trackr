import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_button.dart';

class TaskWidget extends StatelessWidget {
  onTimerButtonTap() {
    print('тап есть');
    var state = di<BottomWidgetBloc>().state;
    if (state is TaskIsRunningState) {
      print('ивент отправлен');
      di<BottomWidgetBloc>().add(PauseTaskEvent(task));
    } else {
      print('ивент отправлен');
      di<BottomWidgetBloc>().add(RunTaskEvent(task));
    }
  }
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
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          // TODO replace with Theme's color
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO replace with timer button widget
              // const Icon(
              //   Icons.play_circle,
              //   color: const Color.fromARGB(255, 198, 182, 39),
              //   size: 45,
              // ),
              TimerButton(onTap: onTimerButtonTap),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    task.status?.displayName as String,
                    // TODO replace with Theme's style
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      task.title as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}