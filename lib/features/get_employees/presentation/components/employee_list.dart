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
        const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Select employee',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ...employees.map((employee) => EmployeeWidget(employee: employee))
      ],
    );
  }
}