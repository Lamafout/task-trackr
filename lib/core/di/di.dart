import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/core/entities/project_class.dart';
import 'package:task_trackr/core/entities/task_class.dart';
import 'package:task_trackr/core/interceptors/header_interceptor.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/core/sources/remote_source.dart';
import 'package:task_trackr/features/auth/data/auth_repository_impl.dart';
import 'package:task_trackr/features/auth/domain/auth_use_case.dart';
import 'package:task_trackr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_trackr/features/get_employees/data/get_employees_repository_impl.dart';
import 'package:task_trackr/features/get_employees/domain/get_employees_use_case.dart';
import 'package:task_trackr/features/get_employees/presentation/bloc/get_employees_bloc.dart';
import 'package:task_trackr/features/get_projects/data/get_projects_repository_impl.dart';
import 'package:task_trackr/features/get_projects/domain/get_projects_use_case.dart';
import 'package:task_trackr/features/get_projects/presentation/bloc/get_projects_bloc.dart';
import 'package:task_trackr/features/get_tasks/data/get_tasks_repository_impl.dart';
import 'package:task_trackr/features/get_tasks/domain/get_tasks_usecase.dart';
import 'package:task_trackr/features/get_tasks/presentation/bloc/get_tasks_bloc.dart';
import 'package:task_trackr/features/select_employee/data/select_employee_repository_impl.dart';
import 'package:task_trackr/features/select_employee/domain/select_employee_use_case.dart';
import 'package:task_trackr/features/select_employee/presentation/bloc/set_employee_bloc.dart';
import 'package:task_trackr/features/write_off_time/data/write_off_repository_impl.dart';
import 'package:task_trackr/features/write_off_time/domain/write_off_use_case.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/bottom_widget_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/bloc/write_off_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

final di = GetIt.instance;

Future<void> setupDi() async {
  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(sharedPreferences);

  // Hive
  final taskBox = await Hive.openBox<TaskClass>('tasks');
  di.registerSingleton<Box<TaskClass>>(taskBox);
  final projectBox = await Hive.openBox<Project>('projects');
  di.registerSingleton<Box<Project>>(projectBox);

  // interceptors
  di.registerSingleton<HeaderInterceptor>(HeaderInterceptor());

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

  // set employee feature
  di.registerLazySingleton<SelectEmployeeRepositoryImpl>(() => SelectEmployeeRepositoryImpl(di<LocalSource>()));
  di.registerLazySingleton<SelectEmployeeUseCase>(() => SelectEmployeeUseCase(di<SelectEmployeeRepositoryImpl>()));
  di.registerSingleton(SetEmployeeBloc());

  // get list of projects feature
  di.registerLazySingleton<GetProjectsRepositoryImpl>(() => GetProjectsRepositoryImpl(remoteSource:  di<RemoteSource>(), localSource: di<LocalSource>()));
  di.registerLazySingleton<GetProjectsUseCase>(() => GetProjectsUseCase(di<GetProjectsRepositoryImpl>()));
  di.registerSingleton<GetProjectsBloc>(GetProjectsBloc());

  // get list of tasks feature
  di.registerLazySingleton<GetTasksRepositoryImpl>(() => GetTasksRepositoryImpl(remoteSource:  di<RemoteSource>(), localSource: di<LocalSource>()));
  di.registerLazySingleton<GetTasksUseCase>(() => GetTasksUseCase(di<GetTasksRepositoryImpl>()));
  di.registerSingleton<GetTasksBloc>(GetTasksBloc());

  // write off time feature
  di.registerLazySingleton<WriteOffRepositoryImpl>(() => WriteOffRepositoryImpl(di<RemoteSource>(), di<LocalSource>()));
  di.registerLazySingleton<WriteOffUseCase>(() => WriteOffUseCase(di<WriteOffRepositoryImpl>()));
  di.registerSingleton<WriteOffBloc>(WriteOffBloc());
  di.registerSingleton<BottomWidgetBloc>(BottomWidgetBloc());
  di.registerSingleton<TimerButtonCubit>(TimerButtonCubit());
}