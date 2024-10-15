import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_trackr/config/statuses.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/auth/presentation/components/auth_screen.dart';
import 'package:task_trackr/features/get_projects/presentation/bloc/get_projects_bloc.dart';
import 'package:task_trackr/features/get_projects/presentation/components/projects_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(TaskClassAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(StatusesAdapter());

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
      home: 
          Scaffold(
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
                    return const ProjectsScreen();
                  } else if (state is AuthenticationIsFailureState) {
                    return const AuthScreen();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          // const Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TimerBottomWidget(),
            // ],
          // ),
    );
  }
}