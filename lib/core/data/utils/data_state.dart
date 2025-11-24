abstract class DataState<T> {
  DataState({
    this.error,
    this.result,
  });

  final Object? error;
  final T? result;
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required super.result
  });
}

class DataLoading<T> extends DataState<T> {}

class DataFailure<T> extends DataState<T> {
  DataFailure({
    required super.error,
  });
}