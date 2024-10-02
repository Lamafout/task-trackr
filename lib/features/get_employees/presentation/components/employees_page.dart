import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employee_list.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => EmployeesPageState();
}

class EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: BlocBuilder(
          bloc: di<GetEmployeesBloc>(),
          builder: (context, state) {
            switch (state) {
              case LoadingListOfEmployeesState():
                print('loading');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadedListOfEmployeesState():
                print('loaded');
                return EmployeeList(employees: state.employees);
              case FailureWhileLoadedListOfEmployeesState():
                print('failure');
                return Center(child: Text(state.errorMessage),);
              default: 
                print('initial');
                return Container();
            }
          },
        ),
      ),
    );
  }
}