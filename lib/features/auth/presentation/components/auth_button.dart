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
      child: Platform.isAndroid 
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            onPressed: onTap, 
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          )
        : CupertinoButton(
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            onPressed: onTap,
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ), 
          ),
    );
  }
}