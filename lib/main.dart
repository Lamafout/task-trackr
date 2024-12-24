import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_trackr/config/project_statuses.dart';
import 'package:task_trackr/config/task_statuses.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/running_timer_state_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/theme/dark_theme.dart';
import 'package:task_trackr/core/theme/light_theme.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/auth/presentation/components/auth_screen.dart';
import 'package:task_trackr/features/cached_timer/presentation/bloc/cached_timer_bloc.dart';
import 'package:task_trackr/features/get_projects/presentation/bloc/get_projects_bloc.dart';
import 'package:task_trackr/features/get_projects/presentation/components/projects_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(TaskClassAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(TaskStatusesAdapter());
  Hive.registerAdapter(ProjectStatusesAdapter());
  Hive.registerAdapter(RunningTimerStateAdapter());

  await dotenv.load(fileName: 'lib/core/server_token.env');
  await setupDi();
  runApp(const TrackerApp());
}

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    di<AuthBloc>().add(EnterIntoApplication()); // Запуск события аутентификации
    di<CachedTimerBloc>().add(GetStateFromCacheEvent()); // Запуск события для поиска в кэше информации о текущем таске

    return MaterialApp(
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.dark,

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
                if (Platform.isIOS) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(context, MaterialWithModalsPageRoute(builder: (context) => const ProjectsScreen()));
                  });
                  return const Center(child: CupertinoActivityIndicator(),);
                } else {
                  return const ProjectsScreen();
                }
                
              } else if (state is AuthenticationIsFailureState) {
                return const AuthScreen();
              } else {
                return Column(
                  children: [
                    Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}