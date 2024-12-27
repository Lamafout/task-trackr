import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_trackr/core/entities/employee_class.dart';
import 'package:task_trackr/core/theme/colors.dart';

class EmpployeeAvatar extends StatelessWidget {
  final Employee employee;
  const EmpployeeAvatar({
    super.key,
    required this.employee
  });


  @override
    Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(90)),
      child: SizedBox(
        height: 35,
        width: 35,
        child: employee.photo != null
        ? CachedNetworkImage(
          fit: BoxFit.fitWidth,
          imageUrl: employee.photo!,

          placeholder: (context, url) => Container(
            padding: const EdgeInsets.all(25), 
            child: Platform.isIOS 
            ? CupertinoActivityIndicator(
              color: Theme.of(context).primaryColor,
            ) 
            : CircularProgressIndicator(
              strokeWidth: 4, 
              color: Theme.of(context).primaryColor,
            )
          ),

          errorWidget: (context, url, error) => EmptyAvatar(employee: employee),

          filterQuality: FilterQuality.none,
          useOldImageOnUrlChange: true,
        )
        : EmptyAvatar(employee: employee)
      ),
    );
  }
}

class EmptyAvatar extends StatelessWidget {
  final Employee employee;

  const EmptyAvatar({
    super.key,
    required this.employee
  });

  String _getInitials(){
    if (employee.name!.split(' ').length == 2 && employee.name!.split(' ')[1].isNotEmpty) {
      final splittedName = employee.name!.toUpperCase().split(' ');
      return splittedName[0][0] + splittedName[1][0];
    } else {
      return employee.name!.toUpperCase()[0] + employee.name!.toUpperCase()[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appItemsColors[Random().nextInt(appItemsColors.length - 2) + 2],
      padding: const EdgeInsets.all(2),
      child: Center(
        child: Text(
          _getInitials(),
          style: Theme.of(context).primaryTextTheme.titleMedium
        ),
      ),
    );
  }
}