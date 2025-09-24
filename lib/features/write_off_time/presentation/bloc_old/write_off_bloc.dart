import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/features/write_off_time/domain/write_off_use_case.dart';

part 'write_off_event.dart';
part 'write_off_state.dart';

class WriteOffBloc extends Bloc<WriteOffEvent, WriteOffState> {
  WriteOffBloc() : super(WriteOffInitial()) {
    on<WriteOffAndPostComment>((event, emit) async {
      emit(WriteOffLoading());
      final useCases = di<WriteOffUseCase>();
      final result = await useCases.tapOnTimerButton(time: event.time, comment: event.comment, taskID: event.task);
      result.fold(
        (failure) => emit(WriteOffFailure()),
        (success) => emit (WriteOffSuccess()),
      );
      await Future.delayed(const Duration(microseconds: 200), () => emit(WriteOffInitial()));
    });
  }
}
