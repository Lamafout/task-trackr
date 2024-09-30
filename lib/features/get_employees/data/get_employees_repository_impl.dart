import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/exceptions/exceptions.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/core/sources/remote_source.dart';
import 'package:task_trackr/features/get_employees/domain/get_employees_repository.dart';

class GetEmpoyeesRepositoryImpl implements GetEmployeesRepository {
  final RemoteSource _remoteSource;
  GetEmpoyeesRepositoryImpl(this._remoteSource);
  @override
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      final result = await _remoteSource.getEmployees();
      return Right(result);
    } on InternetException catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}