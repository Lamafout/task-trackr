import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/select_employee/presentation/bloc/set_employee_bloc.dart';

class EmployeeWidget extends StatelessWidget {
  final Employee employee;
  const EmployeeWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
        di<SetEmployeeBloc>().add(SubmitEmployee(employee));
        Future.delayed(const Duration(milliseconds: 100),
        () {
          di<AuthBloc>().add(EnterIntoApplication());
          Navigator.pop(context);
        });
      },
        child: Container(
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              smoothness: 0.6,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
          margin: const EdgeInsets.only(bottom: 5, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: employee.photo != null
                      ? CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: employee.photo!,
                        placeholder: (context, url) => Container(padding: const EdgeInsets.all(25), child: Platform.isIOS ? CupertinoActivityIndicator(color: Theme.of(context).primaryColor,) : CircularProgressIndicator(strokeWidth: 4, color: Theme.of(context).primaryColor,)),
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.person, size: 30);
                        },
                        filterQuality: FilterQuality.none,
                        useOldImageOnUrlChange: true,
                      )
                      : const Icon(Icons.person, size: 30),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      employee.name ?? '',
                      style: Platform.isIOS
                      ? Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontFamily: 'San-Francisco', fontSize: 18)
                      : Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}