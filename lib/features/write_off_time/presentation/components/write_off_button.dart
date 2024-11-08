import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/cached_timer/presentation/bloc/cached_timer_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/write_off_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

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
    return BlocListener(
      bloc: di<WriteOffBloc>(),
      listener: (context, state) {
        if (state is WriteOffSuccess) {
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
                di<WriteOffBloc>().add(WriteOffAndPostComment(
                    time: (di<TimerButtonCubit>().state as TimerIsWorksState)
                        .time
                        .inSeconds,
                    comment: value,
                    task: task.id!));
                di<TimerButtonCubit>()
                    .stopTimer();
                di<CachedTimerBloc>().add(ClearStateFromCacheEvent()); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
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
                    if (state is WriteOffSuccess) {
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
                di<WriteOffBloc>().add(WriteOffAndPostComment(
                    time: (di<TimerButtonCubit>().state as TimerIsWorksState)
                        .time
                        .inSeconds,
                    comment: value,
                    task: task.id!));
                di<TimerButtonCubit>()
                    .stopTimer();
                di<CachedTimerBloc>().add(ClearStateFromCacheEvent()); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
                Navigator.pop(context);
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
                          color: Colors.black.withOpacity(0.8),
                        ));
                  } else {
                    if (state is WriteOffSuccess) {
                      Navigator.pop(context);
                    }
                    return Padding(
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
            );
          }
        ),
        // child: Platform.isIOS
        //     ? CupertinoButton(
        //         padding: const EdgeInsets.symmetric(horizontal: 50),
        //         color: Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor,
        //         onPressed: () {
        //           di<WriteOffBloc>().add(WriteOffAndPostComment(
        //               time: (di<TimerButtonCubit>().state as TimerIsWorksState)
        //                   .time
        //                   .inSeconds,
        //               comment: textEditingController.text,
        //               task: task.id!));
        //           di<TimerButtonCubit>()
        //               .stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
        //           Navigator.pop(context);
        //         },
        //         child: BlocBuilder(
        //             bloc: di<WriteOffBloc>(),
        //             builder: (context, state) {
        //               if (state is WriteOffLoading) {
        //                 return const CupertinoActivityIndicator();
        //               } else {
        //                 if (state is WriteOffSuccess) {
        //                   Navigator.pop(context);
        //                 }
        //                 return Text(
        //                   'Write off time',
        //                   style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco', color: Colors.white),
        //                 );
        //               }
        //             }))
        //     : ElevatedButton(
        //         onPressed: () {
        //           di<WriteOffBloc>().add(WriteOffAndPostComment(
        //               time: (di<TimerButtonCubit>().state as TimerIsWorksState)
        //                   .time
        //                   .inSeconds,
        //               comment: textEditingController.text,
        //               task: task.id!));
        //           di<TimerButtonCubit>()
        //               .stopTimer(); // ивент разблокирует кнопки тасков, делая текущий таск незапущенным
        //         },
        //         child: BlocBuilder(
        //             bloc: di<WriteOffBloc>(),
        //             builder: (context, state) {
        //               if (state is WriteOffLoading) {
        //                 return Container(
        //                     width: 30,
        //                     height: 30,
        //                     padding: const EdgeInsets.all(5),
        //                     child: CircularProgressIndicator(
        //                       color: Theme.of(context).indicatorColor,
        //                     ));
        //               } else {
        //                 return Text(
        //                   'Write off time',
        //                   style: Theme.of(context)
        //                       .primaryTextTheme
        //                       .titleMedium!
        //                       .copyWith(color: Colors.white),
        //                 );
        //               }
        //             })),
      ),
    );
  }
}
