import 'package:task_trackr/features/auth/domain/auth_repository.dart';
import 'package:task_trackr/index.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalSource _localSource;
  AuthRepositoryImpl(this._localSource);

  @override
  Future<DataState<String>> getUserID() async {
    try {
      final id = _localSource.getID();
      return DataSuccess(result: id);
    } on NoIDException catch(e) {
      return DataFailure(error: Failure(e.toString()));
    }
  }
}