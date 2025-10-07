part of 'timer_bloc.dart';

class TimerState extends Equatable {
    const TimerState({
        this.initTime,
        this.currentTime,
        this.task,
        this.comment,
        required this.isPaused,
        this.writeOffResult,
    });

    final String? initTime;
    final String? currentTime;
    final String? comment;
    final TaskClass? task;
    final bool isPaused;

    final DataState<void>? writeOffResult;

    bool get isWritedOffError => writeOffResult is DataFailure;
    bool get isWritedOffSuccess => writeOffResult is DataSuccess;
    bool get isWritedOffLoading => writeOffResult is DataLoading;

    bool get isStarted => initTime != null;
    bool get isRunning => isStarted && !isPaused;

    @override
    List<Object?> get props => [
        initTime,
        currentTime,
        comment,
        task,
        writeOffResult,
        isPaused,
        isStarted,
        isRunning,
        isWritedOffError,
        isWritedOffLoading,
        isWritedOffSuccess,
    ];

    TimerState copyWith({
        Nullable<String>? initTime,
        String? currentTime,
        Nullable<String>? comment,
        Nullable<TaskClass>? task,
        bool? isPaused,
        DataState<void>? writeOffResult,
    }) {
        return TimerState(
            isPaused: isPaused ?? this.isPaused, 
            writeOffResult: writeOffResult ?? this.writeOffResult,
            comment: comment != null ? comment.value : this.comment,
            currentTime: currentTime ?? this.currentTime,
            initTime: initTime != null ? initTime.value : this.initTime,
            task: task != null ? task.value : this.task,
        );
    }
}

class TimerInitial extends TimerState {
    const TimerInitial() : super(
        isPaused: false,
        writeOffResult: null,
        comment: null,
        currentTime: null,
        initTime: null,
        task: null,
    );
}
