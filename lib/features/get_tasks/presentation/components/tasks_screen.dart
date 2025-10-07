import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/components/ios_like_scroll_physics.dart';
import 'package:task_trackr/core/components/logger_header.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/models/project_class.dart';
import 'package:task_trackr/core/models/task_class.dart';
import 'package:task_trackr/features/get_tasks/presentation/bloc/get_tasks_bloc.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/task_widget.dart';
import 'package:task_trackr/features/timer/index.dart';

class TasksScreen extends StatelessWidget {
  final Project project;
  const TasksScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return _Content(key: key, project: project);
  }
}

class _Content extends StatefulWidget {
  final Project project;
  const _Content({super.key, required this.project});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  void initState() {
    super.initState();
    di<GetTasksBloc>().add(GetTasksOfProjectsEvent(widget.project.id!));
  }

  List<Widget> _drawListOfTasks({required List<TaskClass> tasks, required BuildContext context}) { // нужно для того, чтобы поделить на блоки по статусам
    String currentStatus = '';
    final resultList = <Widget>[];
    for (var task in tasks) {
      if (task.status!.displayName == currentStatus) {
        resultList.add(Center(child: TaskWidget(task: task)));
      } else {
        currentStatus = task.status!.displayName;
        resultList.add(
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              task.status!.displayName,
              style: Theme.of(context).primaryTextTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700, color: task.status!.color),
              maxLines: 2,
            ),
          ),
        );
        resultList.add(Center(child: TaskWidget(task: task,)));
      }
    }
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: Platform.isIOS
        ? const AlwaysBouncingScrollPhysics()
        : null,
        slivers: [
          SliverAppBar(
            pinned: true,
            surfaceTintColor: Colors.transparent,
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
              title: LoggerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      child: widget.project.icon != null 
                      ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImage(
                          imageUrl: widget.project.icon as String,  
                          errorWidget: (context, url, error) {
                            return Container(
                              color: Theme.of(context).cardColor,
                              child: Icon(
                                Icons.folder,
                                color: Theme.of(context).primaryTextTheme.displaySmall!.color, 
                                size: 20,
                              ),
                            ); 
                          },
                        ),
                      )
                      : Container(
                        height: 30,
                        width: 30,
                        color: Theme.of(context).cardColor,
                        child: Icon(
                            Icons.folder,
                            color: Theme.of(context).primaryTextTheme.displaySmall!.color,
                            size: 20,
                          ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.project.name as String,
                        style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder(
              bloc: di<GetTasksBloc>(),
              builder:(context, state) {
                switch (state) {
                  case GotTasksState():
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._drawListOfTasks(tasks: state.tasks, context: context),
                        BlocBuilder<TimerBloc, TimerState>(
                          bloc: context.read<TimerBloc>(),
                          builder: (context, state) {
                            if (state.isStarted) {
                              return const SizedBox(height: 75,);
                            } else {
                               return const SizedBox(height: 0,);
                            }
                          },
                        )
                      ],
                    );

                  case HaveNotTasksInThisProjectState():
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8, 
                      child: Center(
                        child: Text(
                          'You have not any tasks in this project',
                          style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                        ),
                      )
                    );

                  case FailureWhileGettingTasksState():
                    return  SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: Center(child: Text(state.errorMessage),));
                  
                  default:
                    return Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8, 
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).progressIndicatorTheme.color,
                          )
                        )
                      ),
                    );
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
