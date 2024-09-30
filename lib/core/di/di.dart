import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/core/interceptors/header_interceptor.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/core/sources/remote_source.dart';
import 'package:task_trackr/features/auth/data/auth_repository_impl.dart';
import 'package:task_trackr/features/auth/domain/auth_use_case.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/get_employees/data/get_employees_repository_impl.dart';
import 'package:task_trackr/features/get_employees/domain/get_employees_use_case.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';

final di = GetIt.instance;

Future<void> setupDi() async {
  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(sharedPreferences);

  // interceptors
  di.registerLazySingleton<HeaderInterceptor>(() => HeaderInterceptor());
  
  // sources
  di.registerSingleton<LocalSource>(LocalSource());
  di.registerSingleton<RemoteSource>(RemoteSource());


  // auth feature
  di.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(di<LocalSource>()));
  di.registerLazySingleton<AuthUseCase>(() => AuthUseCase(di<AuthRepositoryImpl>()));
  di.registerSingleton<AuthBloc>(AuthBloc());

  // get employees feature
  di.registerLazySingleton<GetEmpoyeesRepositoryImpl>(() => GetEmpoyeesRepositoryImpl(di<RemoteSource>()));
  di.registerLazySingleton<GetEmployeesUseCase>(() => GetEmployeesUseCase(di<GetEmpoyeesRepositoryImpl>()));
  di.registerSingleton<GetEmployeesBloc>(GetEmployeesBloc());
}