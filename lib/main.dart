import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/auth/presentation/components/auth_screen.dart';
import 'package:task_trackr/features/get_projects/presentation/bloc/get_projects_bloc.dart';
import 'package:task_trackr/features/get_projects/presentation/components/list_of_projects.dart';

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
    di<AuthBloc>().add(EnterIntoApplication()); // Запуск события аутентификации

    return MaterialApp(
      home: Scaffold(
        body: BlocListener(
          bloc: di<AuthBloc>(),
          listener: (context, state) {
            if (state is AuthenticationIsSuccessState) {
              // Когда аутентификация успешна, запускаем событие для загрузки проектов
              di<GetProjectsBloc>().add(ShowListOfActiveProjectsEvent());
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: di<AuthBloc>(),
            builder: (context, state) {
              if (state is AuthenticationIsSuccessState) {
                return BlocBuilder<GetProjectsBloc, GetProjectsState>(
                  bloc: di<GetProjectsBloc>(),
                  builder: (context, state) {
                    if (state is FailureWhileGettingProjectsState) {
                      print('error while getting projects');
                      // TODO: Добавить кнопку для повторного запроса
                      return const Icon(Icons.error);
                    } else if (state is GotListOfProjectsState) {
                      print('success while getting projects');
                      return ListOfProjects(listOfProjects: state.projects);
                    } else {
                      print('initial in getting projects');
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else if (state is AuthenticationIsFailureState) {
                return const AuthScreen();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}