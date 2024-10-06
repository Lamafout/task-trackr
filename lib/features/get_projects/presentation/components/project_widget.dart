import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_trackr/core/entities/project_class.dart';

class ProjectWidget extends StatelessWidget {
  final Project project;
  const ProjectWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO add on tap functionality
        print('Name: ${project.name}, ID: ${project.id}');
      },
      child: ClipRRect(
        //TODO replace with Theme 
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              project.icon != null 
              ? SizedBox(
                height: 30,
                width: 30,
                child: CachedNetworkImage(
                  imageUrl: project.icon as String,  
                  errorWidget: (context, url, error) => const Icon(Icons.smartphone_rounded, size: 30,),
                ),
              )
              : const Icon(
                Icons.smartphone_rounded,
                size: 30,
              ),
        
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  project.name as String,
                  //TODO replace with Theme
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}