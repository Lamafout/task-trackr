import 'package:flutter/material.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/features/get_employees/presentation/components/employee_widget.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key, required this.employees});
  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...employees.map((employee) => EmployeeWidget(employee: employee))
      ],
    );
  }
}