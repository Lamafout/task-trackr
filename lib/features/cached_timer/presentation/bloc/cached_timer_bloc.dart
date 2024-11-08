import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/features/write_off_time/presentation/cubit/timer_button_cubit.dart';

part 'cached_timer_event.dart';
part 'cached_timer_state.dart';

class CachedTimerBloc extends Bloc<CachedTimerEvent, CachedTimerState> {
  CachedTimerBloc() : super(CachedTimerInitial()) {
    on<GetStateFromCacheEvent>((event, emit) {
      
    });
  }
}
