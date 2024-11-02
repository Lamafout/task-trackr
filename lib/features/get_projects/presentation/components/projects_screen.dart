import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/features/get_projects/presentation/bloc/get_projects_bloc.dart';
import 'package:task_trackr/features/get_projects/presentation/components/project_widget.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_bottom_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});
  List<Widget> _drawListOfProjects({required List<Project> projects, required BuildContext context}) { // нужно для того, чтобы поделить на блоки по статусам
    String currentStatus = '';
    final resultList = <Widget>[];
    for (var project in projects) {
      if (project.status!.displayName == currentStatus) {
        resultList.add(Center(child: ProjectWidget(project: project)));
      } else {
        currentStatus = project.status!.displayName; // меняем текущий статус на новый
        resultList.add(
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              project.status!.displayName,
              style: Platform.isIOS
              ? Theme.of(context).primaryTextTheme.headlineLarge!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.w600)
              : Theme.of(context).primaryTextTheme.headlineLarge,
            ),
          ),
        );
        resultList.add(Center(child: ProjectWidget(project: project)));
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
            automaticallyImplyLeading: false,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Projects',
                style: Platform.isIOS
                ? Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.bold)
                : Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder(
                bloc: di<GetProjectsBloc>(),
                builder: (context, state) {
                  switch (state) {
                    case GotListOfProjectsState():
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._drawListOfProjects(projects: state.projects, context: context),
                          const SizedBox(height: 90)
                        ],
                      );
                    case FailureWhileGettingProjectsState():
                      return const Icon(Icons.error);
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          )
        ],
      ),
      bottomSheet: const TimerBottomWidget(),
    );
  }
}
