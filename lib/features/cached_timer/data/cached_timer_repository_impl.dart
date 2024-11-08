import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/features/cached_timer/domain/cached_timer_repository.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

class CachedTimerRepositoryImpl implements CachedTimerRepository {
  final LocalSource localSource;

  CachedTimerRepositoryImpl({required this.localSource});

  @override
  Future<Either<Failure, void>> saveTimerState({required TimerIsWorksState state}) async {
    try {
       await localSource.saveTimerState(state);
       return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimerIsWorksState?>> getTimerState() async {
     try {
      final result = await localSource.getTimerState();
      return Right(result);
     } on Exception catch (e) {
      return Left(Failure(e.toString()));
     }
  }

  @override
  Future<Either<Failure, void>> deleteTimerState() async {
    try {
      await localSource.clearStates();
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}