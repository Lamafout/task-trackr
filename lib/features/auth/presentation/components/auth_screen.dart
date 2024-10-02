import 'package:flutter/material.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/auth/presentation/components/auth_button.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employees_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hola 👋 ',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          AuthButton(onTap: () {
            di<GetEmployeesBloc>().add(GetListOfEmployees());
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const EmployeesPage();
              }
            );
          })
        ]
      ),
    );
  }
}