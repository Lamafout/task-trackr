import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ColorScheme darkColorScheme = ColorScheme.fromSwatch(brightness: Brightness.dark , primarySwatch: Colors.indigo, backgroundColor: Colors.grey[700] ,cardColor: Colors.grey[850]);

final String? fontFamily = Platform.isIOS ? 'SF-Pro' : null;

final appDarkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,

  // iOS like page transition (change to .android for tests)
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder> {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    }
  ),

  fontFamily: fontFamily,

  primaryTextTheme: const TextTheme(
    displaySmall: TextStyle(
      color: Colors.white
    ),
    labelMedium: TextStyle(
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ), 
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ), 
    titleLarge: TextStyle(
      color: Colors.white
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600
    ),
    bodyMedium: TextStyle(
      color: Colors.white
    ),
    bodySmall: TextStyle(
      color: Colors.white
    )
  ),
    iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        } else {
          return darkColorScheme.primary;
        }
      }),
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 50)),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        } else {
          return darkColorScheme.primary;
        }
      }),
      textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      )),
      shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent)
    )
  ),
  cardColor: const Color(0xFF161516),
  appBarTheme: const AppBarTheme(
    color: Colors.black
  ),
  scaffoldBackgroundColor: Colors.black,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent
  ),
  iconTheme: const IconThemeData(
    color: Colors.grey
  ),
);