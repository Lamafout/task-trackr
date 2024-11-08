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

    ColorScheme lightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.indigo,);
    ColorScheme darkColorScheme = ColorScheme.fromSwatch(brightness: Brightness.dark , primarySwatch: Colors.indigo, backgroundColor: Colors.grey[700] ,cardColor: Colors.grey[850]);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,

        // iOS like page transition (change to .android for tests)
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder> {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }
        ),

        primaryTextTheme: const TextTheme(
          displaySmall: TextStyle(
            color: Colors.black
          ),
          labelLarge: TextStyle(
            color: Colors.black
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), 
          headlineMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ), 
          titleLarge: TextStyle(
            color: Colors.black
          ),
          titleMedium: TextStyle(
            color: Colors.black
          ),
          bodyMedium: TextStyle(
            color: Colors.black87
          ),
          bodySmall: TextStyle(
            color: Colors.black
          )
        ),
          iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              } else {
                return lightColorScheme.primary;
              }
            }),
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 50)),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              } else {
                return lightColorScheme.secondaryContainer;
              }
            }),
            textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
            shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent)
          )
        ),
        cardColor: Colors.grey[300],
        scaffoldBackgroundColor: lightColorScheme.surface,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey
        ),

        // cupertino
        cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
          primaryContrastingColor: Colors.blue[100]
        )
      ),

      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,

        // iOS like page transition (change to .android for tests)
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder> {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }
        ),


        primaryTextTheme: const TextTheme(
          displaySmall: TextStyle(
            color: Colors.white
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ), 
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ), 
          titleLarge: TextStyle(
            color: Colors.white
          ),
          titleMedium: TextStyle(
            color: Colors.white
          ),
          bodyMedium: TextStyle(
            color: Colors.white
          ),
          bodySmall: TextStyle(
            color: Colors.white
          )
        ),
          iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              } else {
                return darkColorScheme.primary;
              }
            }),
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 50)),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              } else {
                return darkColorScheme.primary;
              }
            }),
            textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
            shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent)
          )
        ),
        cardColor: const Color(0xFF161516),
        appBarTheme: const AppBarTheme(
          color: Colors.black
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey
        ),

        // cupertino
        cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
          primaryContrastingColor: Color.fromARGB(255, 55, 68, 93)
        )
      ),

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