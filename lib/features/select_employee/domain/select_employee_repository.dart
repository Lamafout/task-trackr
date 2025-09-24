import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/models/employee_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';

abstract class SelectEmployeeRepository {
  Future<Either<Failure, bool>> selectEmployee(Employee selectedEmployee);
}