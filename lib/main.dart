import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
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

  await dotenv.load(fileName: 'lib/core/server_token.env');
  await setupDi();
  runApp(const TrackerApp());
}

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    di<AuthBloc>().add(EnterIntoApplication()); // Запуск события аутентификации

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme = lightDynamic ?? ColorScheme.fromSwatch(accentColor: Colors.blue);
        ColorScheme darkColorScheme = darkDynamic ?? ColorScheme.fromSwatch(accentColor: Colors.blue);
        return MaterialApp(
          theme: ThemeData(
            // colorScheme: lightColorScheme,
            useMaterial3: true,
            primaryTextTheme: TextTheme(
              headlineLarge: TextStyle(
                fontSize: 18,
                color:  
                Colors.black,
                fontWeight: FontWeight.w500,
              )
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const BorderSide(
                      color: Colors.grey,
                      width: 4
                    );
                  } else {
                    return const BorderSide(
                      color: Colors.blue,
                      width: 4
                    );
                  }
                }),
                iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.grey;
                  } else {
                    return Colors.blue;
                  }
                }),
                backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
              )
            ),
        
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.grey;
                  } else {
                    return Colors.blue;
                  }
                }),
                textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),
                shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent)
              )
            ),
          ),

          darkTheme: ThemeData(
            // colorScheme: darkColorScheme,
            useMaterial3: true,
            primaryTextTheme: const TextTheme(
              labelMedium: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
              headlineLarge: TextStyle(
                fontSize: 18,
                color:  
                Colors.white,
                fontWeight: FontWeight.w500,
              ), 
              bodyMedium: TextStyle(
                color: Colors.white70
              ),
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const BorderSide(
                      color: Colors.grey,
                      width: 4
                    );
                  } else {
                    return const BorderSide(
                      color: Color.fromARGB(255, 33, 37, 243),
                      width: 4
                    );
                  }
                }),
                iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.grey;
                  } else {
                    return const Color.fromARGB(255, 33, 37, 243);
                  }
                }),
                backgroundColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
              )
            ),

            cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
              primaryColor: Color.fromARGB(255, 33, 37, 243)
            ),
        
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 50)),
                backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.grey;
                  } else {
                    return const Color.fromARGB(255, 33, 37, 243);
                  }
                }),
                textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),
                shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent)
              )
            ),

            scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46),

            appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 46, 46, 46),
            ),

            bottomAppBarTheme: const BottomAppBarTheme(
              color: Color.fromARGB(255, 46, 46, 46),
            ),

            cardColor: const Color.fromARGB(255, 34, 34, 34),
          ),

          themeMode: ThemeMode.system,

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
        );
      },
    );
  }
}