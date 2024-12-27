import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElementPressableContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const ElementPressableContainer({
    super.key,
    required this.onPressed,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        child: child,
      )
    : Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: child,
        ),
    );
  }
}