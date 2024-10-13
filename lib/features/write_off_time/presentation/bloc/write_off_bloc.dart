import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'write_off_event.dart';
part 'write_off_state.dart';

class WriteOffBloc extends Bloc<WriteOffEvent, WriteOffState> {
  WriteOffBloc() : super(WriteOffInitial()) {
    on<WriteOffEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
