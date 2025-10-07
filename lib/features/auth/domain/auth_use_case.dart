import 'package:task_trackr/features/auth/index.dart';
import 'package:task_trackr/index.dart';

class AuthUseCase {
  final AuthRepository _repository;
  AuthUseCase(this._repository);

  Future<DataState<String>> enterIntoApplication() async {
    final response = await _repository.getUserID();
    return response;
  }
}