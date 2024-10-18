import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/write_off_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class WriteOffPage extends StatefulWidget {
  final TaskClass task;

  WriteOffPage({
    super.key,
    required this.task,
  });

  @override
  State<WriteOffPage> createState() => _WriteOffPageState();
}

class _WriteOffPageState extends State<WriteOffPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          // TODO replace with Theme
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add comment to task',
                // TODO replace with Theme
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none
                  ),
                  // TODO replace with Theme
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              // TODO add platform style
              ElevatedButton(
                onPressed: () {
                  di<WriteOffBloc>().add(WriteOffAndPostComment(time: (di<BottomWidgetBloc>().state as TaskIsPausedState).time.inSeconds, comment: _textEditingController.text, task: widget.task.id!));
                  di<BottomWidgetBloc>().add(StopTaskEvent()); // ивент заканчивает работу таймера нижнего виджета
                  di<TimerButtonCubit>().stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
                  Navigator.pop(context);
                }, 
                child: const Text('Write off time'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}