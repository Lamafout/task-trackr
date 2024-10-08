import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/features/get_tasks/presentation/bloc/get_tasks_bloc.dart';
import 'package:task_trackr/features/get_tasks/presentation/components/tasks_screen.dart';

class ProjectWidget extends StatelessWidget {
  final Project project;
  const ProjectWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          di<GetTasksBloc>().add(GetTasksOfProjectsEvent(project.id as String));
          Navigator.push(context, MaterialPageRoute(builder: (context) => TasksScreen(project: project)));
        },
        child: ClipRRect(
          //TODO replace with Theme 
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                project.icon != null 
                ? SizedBox(
                  height: 40,
                  width: 40,
                  child: CachedNetworkImage(
                    imageUrl: project.icon as String,  
                    errorWidget: (context, url, error) => const Icon(Icons.smartphone_rounded, size: 40,),
                  ),
                )
                : const Icon(
                  Icons.smartphone_rounded,
                  size: 40,
                ),
          
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    project.name as String,
                    //TODO replace with Theme
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}