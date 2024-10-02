import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/auth/presentation/components/auth_screen.dart';

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
    di<AuthBloc>().add(EnterIntoApplication());
    return  MaterialApp(
      //TODO удалить после тестирования
      home: Scaffold(
        body: BlocBuilder(
          bloc: di<AuthBloc>(),
          builder: (context, state) {
            switch (state) {
              case AuthenticationIsSuccessState():
                return  Center(
                  child: Text(di<SharedPreferences>().getString('name') as String),
                );
              case AuthenticationIsFailureState():
                return const AuthScreen();
              default: 
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
