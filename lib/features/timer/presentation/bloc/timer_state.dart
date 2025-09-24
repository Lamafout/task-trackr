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

    final Either<Failure, void>? writeOffResult;

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
    ];

    TimerState copyWith({
        String? initTime,
        String? currentTime,
        String? comment,
        TaskClass? task,
        bool? isPaused,
        Either<Failure, void>? writeOffResult,
    }) {
        return TimerState(
            isPaused: isPaused ?? this.isPaused, 
            writeOffResult: writeOffResult ?? this.writeOffResult,
            comment: comment ?? this.comment,
            currentTime: currentTime ?? this.currentTime,
            initTime: initTime ?? initTime,
            task: task ?? this.task,
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