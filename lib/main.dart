import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'lib/core/notion_token.env');
  await setupDi();
  runApp(const TrackerApp());
}

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    di<GetEmployeesBloc>().add(GetListOfEmployees());
    return  MaterialApp(
      //TODO удалить после тестирования
      home: Scaffold(
        body: BlocBuilder(
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
                return Column(
                  children: state.employees.map((employee) => Text(employee.name ?? '')).toList(),
                );
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
