import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/features/get_projects/presentation/components/project_widget.dart';

class ListOfProjects extends StatelessWidget {
  final List<Project> listOfProjects;
  const ListOfProjects({super.key, required this.listOfProjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Projects',
                // TODO replase with Theme
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...listOfProjects.map((project) => ProjectWidget(project: project)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}