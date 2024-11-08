import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/cached_timer/domain/cached_timer_repository.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class CachedTimerUsecases {
  final CachedTimerRepository repository;

  CachedTimerUsecases({
    required this.repository,
  });

  Future<Either<Failure, void>> cacheTimer({required TimerIsWorksState state}) async {
    final result = await repository.saveTimerState(state: state);
    return result.fold(
      (failure) => Left(failure),
      (success) => Right(success)
    );
  }

  Future<Either<Failure, TimerIsWorksState?>> loadTimerFromCache() async {
    final result = await repository.getTimerState();
    return result.fold(
      (failure) => Left(failure),
      (state) => Right(state)
    );
  }

  Future<Either<Failure, void>> clearTimer() async {
     final result = await repository.deleteTimerState();
      return result.fold(
        (failure) => Left(failure),
        (success) => Right(success)
      );
  }
}