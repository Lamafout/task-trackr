import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/cached_timer/domain/cached_timer_usecases.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

part 'cached_timer_event.dart';
part 'cached_timer_state.dart';

class CachedTimerBloc extends Bloc<CachedTimerEvent, CachedTimerState> {
  CachedTimerBloc() : super(CachedTimerInitial()) {
    print('GET FROM CACHE EVENT');
    on<GetStateFromCacheEvent>((event, emit) async {
      final useCases = di<CachedTimerUsecases>();
      final result = await useCases.loadTimerFromCache();
      result.fold(
        (failure) {
          emit(FailureState());
        },
        (state) {
          if (state == null) {
            print('CACHE IS EMPTY');
            emit(CacheIsEmpty());
          } else {
            print('GOT STATE: ${state.task.title}');
            di<TimerButtonCubit>().setTimer(state as TimerIsPausedState);
            emit(GotStateFromCache(state));
          }
          
        }
      );
    });

    on<LoadStateToCacheEvent>((event, emit) async {
      print('LOAD TO CACHE EVENT');
      final useCases = di<CachedTimerUsecases>();
      final result = await useCases.cacheTimer(state: event.state);
      result.fold(
        (failure) {
          emit(FailureState());
        },
        (success) {
          print('LOADED!');
          CachedTimerInitial();
        }
      );
    });

    on<ClearStateFromCacheEvent>((event, emit) async {
      final useCases = di<CachedTimerUsecases>();
      final result = await useCases.clearTimer();
      result.fold(
        (failure) {
          emit(FailureState());
        },
        (success) {
          CachedTimerInitial();
        }
      );
    });
  }
}
