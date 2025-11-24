import 'package:task_trackr/features/employees/index.dart';

class EmployeeDTO extends Employee {
  final String? name;
  final String? email;
  final String? id;
  final String? photo;

  EmployeeDTO({required this.name, required this.email, required this.id, required this.photo});
}