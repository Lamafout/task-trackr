import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employee_list.dart';
import 'package:task_trackr/features/get_projects/presentation/components/projects_screen.dart';
import 'package:task_trackr/features/select_employee/presentation/bloc/set_employee_bloc.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => EmployeesScreenState();
}

class EmployeesScreenState extends State<EmployeesScreen> {
  late final GetEmployeesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = di<GetEmployeesBloc>();
    bloc.add(GetListOfEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: di<SetEmployeeBloc>(),
      listener: (context, state) {
        if (state is SettedState) {
          di<AuthBloc>().add(EnterIntoApplication());
          Navigator.pushReplacement(context, MaterialWithModalsPageRoute(builder: (context) => const ProjectsScreen()));
        }
      },
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            surfaceTintColor: Colors
                .transparent, //this disables material effect when user scrolls screen
            leading: Container(),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Who are you?',
                  style: Theme.of(context).primaryTextTheme.titleLarge),
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
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  case LoadedListOfEmployeesState():
                    return EmployeeList(employees: state.employees);
                  case FailureWhileLoadedListOfEmployeesState():
                    return Column(
                      children: [
                        Center(
                          child: Text(state.errorMessage),
                        ),
                      ],
                    );
                  default:
                    return Container();
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
