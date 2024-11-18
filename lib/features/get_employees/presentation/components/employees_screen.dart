import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employee_list.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => EmployeesScreenState();
}

class EmployeesScreenState extends State<EmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton.outlined(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                side: WidgetStatePropertyAll<BorderSide>(BorderSide.none)
              ),
              onPressed: () {
                Navigator.pop(context);
              }, 
              icon: const Icon(
                Icons.arrow_back,
              )
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Choose your fighter',
                style: Platform.isIOS
                ? Theme.of(context).primaryTextTheme.headlineLarge!.copyWith(fontFamily: 'San-Francisco', fontWeight: FontWeight.w600)
                : Theme.of(context).primaryTextTheme.headlineLarge,
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder(
              bloc: di<GetEmployeesBloc>(),
              builder: (context, state) {
                switch (state) {
                  case LoadingListOfEmployeesState():
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                        child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                      ),
                    );
                  case LoadedListOfEmployeesState():
                    return EmployeeList(employees: state.employees);
                  case FailureWhileLoadedListOfEmployeesState():
                    return Column(
                      children: [
                        Center(child: Text(state.errorMessage),),
                      ],
                    );
                  default: 
                    return Container();
                }
              },
            ),
          )
        ],
      )
    );
  }
}