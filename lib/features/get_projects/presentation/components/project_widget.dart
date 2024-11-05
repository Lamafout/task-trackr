import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          di<GetTasksBloc>().add(GetTasksOfProjectsEvent(project.id as String));
          Navigator.push(
              context,
              Platform.isIOS
              ? MaterialWithModalsPageRoute(builder: (context) => TasksScreen(project: project))
              : MaterialPageRoute(builder: (context) => TasksScreen(project: project))
            ); 
        },
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            width: MediaQuery.of(context).size.width ,
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SmoothClipRRect(
                      smoothness: 0.6,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: project.icon != null 
                      ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImage(
                          imageUrl: project.icon as String,  
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
                      margin: const EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        project.name as String,
                        style: Platform.isIOS
                        ? Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontFamily: 'San-Francisco', fontSize: 18)
                        : Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}