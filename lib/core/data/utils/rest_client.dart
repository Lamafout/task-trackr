import 'package:dio/dio.dart';
import 'package:task_trackr/index.dart';

// TODO: add some logic
InternetException _handleDioError(DioException error) {
  final statusCode = error.response?.statusCode;
  final responseData = error.response?.data;

  String errorMessage = "Неизвестная ошибка сети.";
  
  if (responseData is Map && responseData.containsKey('message')) {
     errorMessage = responseData['message'] as String;
  } else if (statusCode != null) {
     errorMessage = "Ошибка сервера: $statusCode";
  }

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
    case DioExceptionType.connectionError:
    default:
      return InternetException(message: errorMessage, statusCode: statusCode);
  }
}

abstract class RestClient {
  final Dio dio;

  RestClient(this.dio);

  Future<Response<T>> execute<T>(Future<Response<T>> request) async {
    try {
      final response = await request;
      
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e); 
    } catch (e) {
      throw Exception("Ошибка обработки данных: ${e.toString()}");
    }
  }
}

extension FutureToDataStateExtension<T> on Future<T> {
  Future<DataState<T>> toDataState() async {
    try {
      final result = await this;
      return DataSuccess(result: result);
    } on Exception catch (e) {
      return DataFailure(error: e);
    }
  }
}