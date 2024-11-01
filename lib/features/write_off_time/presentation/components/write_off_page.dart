import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/write_off_button.dart';

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
                style: Platform.isIOS
                ? Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontFamily: 'San-Francisco')
                : Theme.of(context).primaryTextTheme.labelMedium,
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor
                  ),
                  controller: _textEditingController,
                  autofocus: true,
                  maxLines: null,
                  minLines: 3,
                  style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco')
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
              WriteOffButton(task: widget.task, textEditingController: _textEditingController,),
            ],
          ),
        ),
      ),
    );
  }
}