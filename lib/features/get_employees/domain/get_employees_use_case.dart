import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/get_employees/domain/get_employees_repository.dart';

class GetEmployeesUseCase {
  final GetEmployeesRepository _getEmployeesRepository;
  GetEmployeesUseCase(this._getEmployeesRepository);

  Future<Either<Failure, List<Employee>>> showListOfEmployees() async {
    final result = await _getEmployeesRepository.getEmployees();
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  } 
}