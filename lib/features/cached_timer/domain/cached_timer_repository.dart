import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

abstract interface class CachedTimerRepository {
  Future<Either<Failure, void>> saveTimerState({required TimerIsWorksState state});
  Future<Either<Failure, TimerIsWorksState?>> getTimerState();
  Future<Either<Failure, void>> deleteTimerState();
}