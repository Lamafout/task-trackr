import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Platform.isIOS 
        ? CupertinoButton(
          color: Theme.of(context).cupertinoOverrideTheme!.primaryContrastingColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onPressed: onTap,
            child: Text(
              'Continue',
              style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontFamily: 'San-Francisco'),
            ), 
          )
        : ElevatedButton(
            
            onPressed: onTap, 
            child: Text(
              'Continue',
              style: Theme.of(context).primaryTextTheme.titleMedium,
            )
          ),
    );
  }
}