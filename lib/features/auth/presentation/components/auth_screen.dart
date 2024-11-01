import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/auth/presentation/components/auth_button.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employees_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hola 👋 ',
            style: Platform.isIOS
            ? Theme.of(context).primaryTextTheme.displaySmall!.copyWith(fontFamily: 'San-Francisco') 
            : Theme.of(context).primaryTextTheme.displaySmall
          ),
          const SizedBox(height: 20),
          AuthButton(onTap: () {
            di<GetEmployeesBloc>().add(GetListOfEmployees());
            Navigator.push(
              context,
              Platform.isIOS
              ? MaterialWithModalsPageRoute(builder: (context) => const EmployeesScreen())
              : MaterialPageRoute(builder: (context) => const EmployeesScreen())
            );            
          })
        ]
      ),
    );
  }
}