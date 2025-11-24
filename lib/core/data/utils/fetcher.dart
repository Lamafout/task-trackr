import 'dart:async';

import 'package:task_trackr/core/data/utils/index.dart';

enum FetchStrategy {
  cacheThenNetwork,
  networkBound,
  cacheOnlyIfValid,
}

class Fetcher {
  const Fetcher._();

  static Stream<DataState<T>> run<T>({
    required Future<T?> Function() fetchLocal,
    required Future<DataState<T>> Function() fetchRemote,
    required Future<void> Function(T) saveLocal,
    FetchStrategy strategy = FetchStrategy.cacheThenNetwork,
  }) async* {
    
    yield DataLoading();
    
    if (strategy == FetchStrategy.cacheThenNetwork) {
      T? localData;
      
      try {
        localData = await fetchLocal();
        if (localData != null) {
          yield DataSuccess(result: localData);
        }
      } catch (_) { /* Continue */ }
      
      try {
        final remoteData = await fetchRemote();

        if (remoteData case DataSuccess remoteSuccess) {
          await saveLocal(remoteSuccess.result);
          yield DataSuccess(result: remoteSuccess.result);
        }
      } catch (e) {
        yield DataFailure(error: e);
      }
      return;
    }

    if (strategy == FetchStrategy.networkBound) {
      try {
        final remoteData = await fetchRemote();

        if (remoteData case DataSuccess remoteSuccess) {
          await saveLocal(remoteSuccess.result);
          yield DataSuccess(result: remoteSuccess.result);
        }
        return;
      } catch (networkError) {
        
        yield DataFailure(error: networkError); 
        
        try {
          final localData = await fetchLocal();
          if (localData != null) {
            yield DataSuccess(result: localData);
          }
        } catch (_) { 
        }
        return;
      }
    }

    if (strategy == FetchStrategy.cacheOnlyIfValid) {
      T? localData;
      try {
        localData = await fetchLocal();
        if (localData != null) {
          yield DataSuccess(result: localData);
          return;
        }
      } catch (_) { /* Continue */ }
      
      try {
        final remoteData = await fetchRemote();
        
        if (remoteData case DataSuccess remoteSuccess) {
          await saveLocal(remoteSuccess.result);
          yield DataSuccess(result: remoteSuccess.result);
        }
      } catch (e) {
        yield DataFailure(error: e);
      }
      return;
    }
  }
}