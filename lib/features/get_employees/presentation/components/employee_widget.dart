import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/select_employee/presentation/bloc/set_employee_bloc.dart';

class EmployeeWidget extends StatelessWidget {
  final Employee employee;
  const EmployeeWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        di<SetEmployeeBloc>().add(SubmitEmployee(employee));
        Future.delayed(const Duration(milliseconds: 100),
        () {
          di<AuthBloc>().add(EnterIntoApplication());
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow:  [
            BoxShadow(
              color: Color.fromARGB(255, 207, 207, 207),
              spreadRadius: 0.1,
              blurRadius: 3,
              blurStyle: BlurStyle.normal
            ),
          ]
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(90)),
              child: SizedBox(
                height: 70,
                width: 70,
                child: employee.photo != null
                ? CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: employee.photo!,
                  placeholder: (context, url) => Container(padding: const EdgeInsets.all(10), child: const CircularProgressIndicator(strokeWidth: 4,)),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.person, size: 60);
                  },
                  filterQuality: FilterQuality.none,
                  useOldImageOnUrlChange: true,
                )
                : const Icon(Icons.person, size: 60),
              ),
            ),
            const SizedBox(width: 20,),
            // TODO add Theme
            Text(
              employee.name ?? '',
              style: Theme.of(context).primaryTextTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}