import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/write_off_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class WriteOffButton extends StatelessWidget {
  final TextEditingController textEditingController;
  final TaskClass task;
  const WriteOffButton(
      {super.key, required this.textEditingController, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: di<WriteOffBloc>(),
      listener: (context, state) {
        if (state is WriteOffSuccess) {
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Platform.isIOS
            ? CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color: Theme.of(context)
                    .cupertinoOverrideTheme!
                    .primaryContrastingColor,
                onPressed: () {
                  di<WriteOffBloc>().add(WriteOffAndPostComment(
                      time: (di<TimerButtonCubit>().state as TimerIsWorksState)
                          .time
                          .inSeconds,
                      comment: textEditingController.text,
                      task: task.id!));
                  di<TimerButtonCubit>()
                      .stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
                  Navigator.pop(context);
                },
                child: BlocBuilder(
                    bloc: di<WriteOffBloc>(),
                    builder: (context, state) {
                      if (state is WriteOffLoading) {
                        return const CupertinoActivityIndicator();
                      } else {
                        if (state is WriteOffSuccess) {
                          Navigator.pop(context);
                        }
                        return Text(
                          'Write off time',
                          style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco', color: Colors.white),
                        );
                      }
                    }))
            : ElevatedButton(
                onPressed: () {
                  di<WriteOffBloc>().add(WriteOffAndPostComment(
                      time: (di<TimerButtonCubit>().state as TimerIsWorksState)
                          .time
                          .inSeconds,
                      comment: textEditingController.text,
                      task: task.id!));
                  di<TimerButtonCubit>()
                      .stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
                },
                child: BlocBuilder(
                    bloc: di<WriteOffBloc>(),
                    builder: (context, state) {
                      if (state is WriteOffLoading) {
                        return Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(5),
                            child: CircularProgressIndicator(
                              color: Theme.of(context).indicatorColor,
                            ));
                      } else {
                        return Text(
                          'Write off time',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        );
                      }
                    })),
      ),
    );
  }
}
