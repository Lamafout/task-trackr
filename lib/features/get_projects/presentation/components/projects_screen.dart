import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/get_projects/presentation/bloc/get_projects_bloc.dart';
import 'package:task_trackr/features/get_projects/presentation/components/project_widget.dart';
import 'package:task_trackr/features/write_off_time/presentation/components/timer_bottom_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Projects',
                // TODO replase with Theme
                style: TextStyle(fontWeight: FontWeight.bold),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...state.projects
                              .map((project) => ProjectWidget(project: project)),
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
