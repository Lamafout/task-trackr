part of 'cached_timer_bloc.dart';

class CachedTimerState {}

class CachedTimerInitial extends CachedTimerState {}

class GotStateFromCache extends CachedTimerState {
  final TimerIsPausedState timerState;
  GotStateFromCache(this.timerState);
}

class CacheIsEmpty extends CachedTimerState {}