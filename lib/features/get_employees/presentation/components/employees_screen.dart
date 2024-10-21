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
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Choose your fighter',
                style: Theme.of(context).primaryTextTheme.labelMedium
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case LoadedListOfEmployeesState():
                    return EmployeeList(employees: state.employees);
                  case FailureWhileLoadedListOfEmployeesState():
                    return Center(child: Text(state.errorMessage),);
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