import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_corner/smooth_corner.dart';
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
          Navigator.push(
              context,
              Platform.isIOS
              ? MaterialWithModalsPageRoute(builder: (context) => TasksScreen(project: project))
              : MaterialPageRoute(builder: (context) => TasksScreen(project: project))
            ); 
        },
        child: SmoothClipRRect(
          smoothness: 0.6,  // iOS default 
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(10),
            color: Theme.of(context).cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmoothClipRRect(
                  smoothness: 0.6,  // iOS default
                  borderRadius: BorderRadius.circular(10),
                  child: project.icon != null 
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
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    project.name as String,
                    style: Platform.isIOS
                    ? Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco')
                    : Theme.of(context).primaryTextTheme.titleMedium,
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