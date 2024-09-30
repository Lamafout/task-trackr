import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${dotenv.env['NOTION_TOKEN']}';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Notion-Version'] = '2022-06-28';
    handler.next(options);
  }
}