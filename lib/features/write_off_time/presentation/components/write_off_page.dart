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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: Container(
        height: Platform.isIOS
        ? null
        : MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.task.status!.color.withOpacity(0.05),
          borderRadius:  Platform.isIOS
          ? null
          : const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder(
              bloc: di<TimerButtonCubit>(),
              builder: (context, state) {
                if (state is TimerButtonInitial) {
                  return Container();
                } else {
                  updateTime((state as TimerIsWorksState).time.inSeconds);
                  return Text(
                    '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: Theme.of(context).primaryTextTheme.displayLarge!.copyWith(fontSize: 75)                    
                  );
                }
              }
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
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
                            style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        Text(
                          widget.task.title!,
                          style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: const BorderRadius.all(Radius.circular(15))
                    ),
                    child: Platform.isIOS
                    ? CupertinoTextField(
                      decoration: const BoxDecoration(
                        color: Colors.transparent
                      ),
                      controller: _textEditingController,
                      autofocus: true,
                      maxLines: null,
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                      placeholder:  'write down what you were doing',
                      cursorColor: widget.task.status!.color,
                    ) 
                    : TextField(
                      controller: _textEditingController,
                      autofocus: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'write down what you were doing',
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryTextTheme.titleMedium!.color!.withOpacity(0.3)
                        )
                      ),
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                      
                      cursorColor: widget.task.status!.color,
                    ),
                  ),
                  WriteOffButton(task: widget.task, notifier: notifier,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}