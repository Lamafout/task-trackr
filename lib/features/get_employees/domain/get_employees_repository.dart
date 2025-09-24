import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/models/employee_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class GetEmployeesRepository {
  Future<Either<Failure, List<Employee>>> getEmployees();
}