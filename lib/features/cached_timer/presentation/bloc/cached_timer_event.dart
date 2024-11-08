part of 'cached_timer_bloc.dart';

class CachedTimerEvent {}

class GetStateFromCacheEvent extends CachedTimerEvent {}
class LoadStateToCacheEvent extends CachedTimerEvent {
  final TimerIsWorksState state;
  LoadStateToCacheEvent(this.state);
}
class ClearStateFromCacheEvent extends CachedTimerEvent {}