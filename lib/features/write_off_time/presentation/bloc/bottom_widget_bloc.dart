import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/entities/task_class.dart';

part 'bottom_widget_event.dart';
part 'bottom_widget_state.dart';

class BottomWidgetBloc extends Bloc<BottomWidgetEvent, BottomWidgetState> {
  Timer? _timer;
  Duration _elapcedTime = const Duration(seconds: 0);
  BottomWidgetBloc() : super(BottomWidgetInitial()) {
    on<RunTaskEvent>((event, emit) {
      _startTimer(event.task);
    });

    on<PauseTaskEvent>((event, emit) {
      _pauseTimer(event.task);
    });
  }
  _startTimer(TaskClass task) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapcedTime += const Duration(seconds: 1);
      emit(TaskIsRunningState(time: _elapcedTime, task: task));
    });
  }

  _pauseTimer(TaskClass task) {
    _timer?.cancel();
    emit(TaskIsPausedState(time: _elapcedTime, task: task));
  }
}
