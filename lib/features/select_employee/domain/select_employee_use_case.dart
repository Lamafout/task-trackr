import 'package:dartz/dartz.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/exceptions/failures.dart';
import 'package:task_trackr/features/select_employee/domain/select_employee_repository.dart';

class SelectEmployeeUseCase {
  final SelectEmployeeRepository _selectEmployeeRepository;

  SelectEmployeeUseCase(this._selectEmployeeRepository);

  Future<Either<Failure, bool>> tapOnSubmitEployeeButton(Employee employee) async {
    final result = await _selectEmployeeRepository.selectEmployee(employee);
    return result.fold(
      (failure) => Left(failure),
      (status) => Right(status),
    );
  }
}