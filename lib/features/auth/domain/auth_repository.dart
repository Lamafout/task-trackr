import 'package:task_trackr/index.dart';

abstract class AuthRepository {
  Future<DataState<String>> getUserID();
}