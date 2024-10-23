import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/get_tasks/presentation/bloc/get_tasks_bloc.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/task_widget.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_bottom_widget.dart';

class TasksScreen extends StatelessWidget {
  final Project project;
  const TasksScreen({super.key, required this.project});

  List<Widget> _drawListOfTasks({required List<TaskClass> tasks, required BuildContext context}) { // нужно для того, чтобы поделить на блоки по статусам
    String currentStatus = '';
    final resultList = <Widget>[];
    for (var task in tasks) {
      if (task.status!.displayName == currentStatus) {
        resultList.add(TaskWidget(task: task));
      } else {
        currentStatus = task.status!.displayName; // меняем текущий статус на новый
        resultList.add(
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                task.status!.displayName,
                style: Platform.isIOS
                ? Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco')
                : Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ),
          ),
        );
        resultList.add(TaskWidget(task: task,));
      }
    }
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            leading: IconButton.outlined(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                side: WidgetStatePropertyAll<BorderSide>(BorderSide.none)
              ),
              onPressed: () {
                di<GetTasksBloc>().add(QuitFromTasksScreenEvent());
                Navigator.pop(context);
              }, 
              icon: const Icon(
                Icons.arrow_back,
              )
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                project.name as String,
                style: Platform.isIOS
                ? Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontFamily: 'San-Francisco')
                : Theme.of(context).primaryTextTheme.labelMedium,
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder(
              bloc: di<GetTasksBloc>(),
              builder:(context, state) {
                switch (state) {
                  case GetTasksLoading():
                    return Center(
                      child: SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: Center(child: CircularProgressIndicator(color: Theme.of(context).indicatorColor,))),
                    );
                  case GotTasksState():
                    return Column(
                      children: [
                        ..._drawListOfTasks(tasks: state.tasks, context: context),
                        const SizedBox(height: 90,)
                      ],
                    );
                  case FailureWhileGettingTasksState():
                    //TODO replace with retry button
                    return  SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: Center(child: Text(state.errorMessage),));
                  default:
                    return Container();
                }
              } ,
            ),
          ),
        ],
      ),
      bottomSheet: const TimerBottomWidget()
    );
  }
}