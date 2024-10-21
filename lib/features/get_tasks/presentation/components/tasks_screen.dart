import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/features/get_tasks/presentation/bloc/get_tasks_bloc.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/task_widget.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_bottom_widget.dart';

class TasksScreen extends StatelessWidget {
  final Project project;
  const TasksScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton.outlined(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                side: WidgetStatePropertyAll<BorderSide>(BorderSide.none)
              ),
              onPressed: () {
                Navigator.pop(context);
              }, 
              icon: const Icon(
                Icons.arrow_back,
              )
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                project.name as String,
                style: Theme.of(context).primaryTextTheme.labelMedium
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case GotTasksState():
                    return Column(
                      children: [
                        ...state.tasks.map((task) => TaskWidget(task: task)),
                      ],
                    );
                  case FailureWhileGettingTasksState():
                    //TODO replace with retry button
                    return  Center(child: Text(state.errorMessage),);
                  default:
                  return Container();
                }
              } ,
            ),
          )
        ],
      ),
      bottomSheet: const TimerBottomWidget()
    );
  }
}