import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trackr/core/di/di.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/local_source.dart';
import 'package:task_trackr/features/select_employee/domain/select_employee_repository.dart';

class SelectEmployeeRepositoryImpl implements SelectEmployeeRepository {
  final LocalSource _localSource;
  SelectEmployeeRepositoryImpl(this._localSource);
  @override
  Future<Either<Failure, bool>> selectEmployee(Employee selectedEmployee) async {
    try {
      await _localSource.setEmployee(selectedEmployee);
      return di<SharedPreferences>().get('user_id') == selectedEmployee.id
      ? const Right(true)
      : const Right(false);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}