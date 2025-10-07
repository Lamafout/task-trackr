import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_trackr/features/auth/data/index.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employees_screen.dart';
import 'package:task_trackr/features/timer/index.dart';
import 'index.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/get_projects/presentation/components/projects_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(TaskClassAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(TaskStatusesAdapter());
  Hive.registerAdapter(ProjectStatusesAdapter());
  Hive.registerAdapter(StartedTimerAdapter());

  await dotenv.load(fileName: 'lib/core/server_token.env');
  await setupDi();

  final Talker talker = TalkerFlutter.init();
  di<Dio>().interceptors.add(TalkerDioLogger(talker: talker));

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Talker>(create: (context) => talker),
        RepositoryProvider<TimerSerivce>(create: (context) => TimerSerivce(
          authRepository: di<AuthRepositoryImpl>(), 
          timerRepository: TimerRepositoryImpl(localSource: di<LocalSource>(), remoteSource: di<RemoteSource>()),
        )),
      ],
      child: const TrackerApp(),
    ),
  );
}

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    di<AuthBloc>().add(EnterIntoApplication());
    return MaterialApp(
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          bloc: di<AuthBloc>(),
          listener: (context, state) {
            if (state is AuthenticationIsSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialWithModalsPageRoute(
                  builder: (context) => const ProjectsScreen(),
                ),
              );
            } else if (state is AuthenticationIsFailureState) {
              Navigator.pushReplacement(
                context,
                MaterialWithModalsPageRoute(
                  builder: (context) => const EmployeesScreen(),
                ),
              );
            }
          },
          child: Center(
            child:
                Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
