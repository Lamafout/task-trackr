import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/write_off_button.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class WriteOffPage extends StatefulWidget {
  final TaskClass task;

  const WriteOffPage({
    super.key,
    required this.task,
  });

  @override
  State<WriteOffPage> createState() => _WriteOffPageState();
}

class _WriteOffPageState extends State<WriteOffPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<String> notifier = ValueNotifier('');
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  updateTime(int newTime) {
    seconds = newTime % 60;
    minutes = (newTime ~/ 60) % 60;
    hours = (newTime ~/ 3600) % 60;
  }

  @override
  void initState() {
    _textEditingController.addListener(() {
      notifier.value = _textEditingController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: widget.task.status!.color.withOpacity(0.05)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder(
            bloc: di<TimerButtonCubit>(),
            builder: (context, state) {
              updateTime((state as TimerIsRunningState).time.inSeconds);
              if (state is TimerButtonInitial) {
                return Container();
              } else {
                return Text(
                  '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  style: !Platform.isIOS
                  ? Theme.of(context).primaryTextTheme.displayMedium!.copyWith(fontFamily: 'San-Francisco', fontSize: 70)
                  : Theme.of(context).primaryTextTheme.displayLarge!.copyWith(fontSize: 70)                    
                );
              }
            }
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        widget.task.projectName!.toUpperCase(),
                        style: Platform.isIOS
                        ? Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.w600) 
                        : Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Text(
                      widget.task.title!,
                      style: Platform.isIOS
                      ? Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.w600) 
                      : Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                child: !Platform.isIOS
                ? CupertinoTextField(
                  
                  decoration: const BoxDecoration(
                    color: Colors.transparent
                  ),
                  controller: _textEditingController,
                  autofocus: true,
                  maxLines: null,
                  minLines: 3,
                  style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.w600)
                ) 
                : TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none
                  ),
                  style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)
                ),
              ),
            ],
          ),
          WriteOffButton(task: widget.task, notifier: notifier,),
        ],
      ),
    );
  }
}