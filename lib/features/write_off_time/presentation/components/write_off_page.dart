import 'dart:io';

import 'package:flutter/cupertino.dart';
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Theme.of(context).scaffoldBackgroundColor
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add comment to task',
                style: Theme.of(context).primaryTextTheme.labelMedium,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                child: Platform.isIOS
                ? CupertinoTextField(
                  controller: _textEditingController,
                  autofocus: true,
                  maxLines: null,
                  style: Theme.of(context).primaryTextTheme.titleMedium
                ) 
                : TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none
                  ),
                  style: Theme.of(context).primaryTextTheme.titleMedium
                ),
              ),
              Platform.isIOS
              ? CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color: Theme.of(context).cupertinoOverrideTheme!.primaryColor,
                onPressed: () {
                  di<WriteOffBloc>().add(WriteOffAndPostComment(time: (di<BottomWidgetBloc>().state as TaskIsPausedState).time.inSeconds, comment: _textEditingController.text, task: widget.task.id!));
                  di<BottomWidgetBloc>().add(StopTaskEvent()); // ивент заканчивает работу таймера нижнего виджета
                  di<TimerButtonCubit>().stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
                  Navigator.pop(context);
                }, 
                child: Text(
                  'Write off time',
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ), 
              )
              : ElevatedButton(
                onPressed: () {
                  di<WriteOffBloc>().add(WriteOffAndPostComment(time: (di<BottomWidgetBloc>().state as TaskIsPausedState).time.inSeconds, comment: _textEditingController.text, task: widget.task.id!));
                  di<BottomWidgetBloc>().add(StopTaskEvent()); // ивент заканчивает работу таймера нижнего виджета
                  di<TimerButtonCubit>().stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
                  Navigator.pop(context);
                }, 
                child: Text(
                  'Write off time',
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}