import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.indigo,);

final appLightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,

  // iOS like page transition (change to .android for tests)
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder> {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    }
  ),

  primaryTextTheme: const TextTheme(
    displaySmall: TextStyle(
      color: Colors.black
    ),
    labelLarge: TextStyle(
      color: Colors.black
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ), 
    headlineMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ), 
    titleLarge: TextStyle(
      color: Colors.black
    ),
    titleMedium: TextStyle(
      color: Colors.black
    ),
    bodyMedium: TextStyle(
      color: Colors.black87
    ),
    bodySmall: TextStyle(
      color: Colors.black
    )
  ),
    iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        } else {
          return lightColorScheme.primary;
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
          return lightColorScheme.secondaryContainer;
        }
      }),
      textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      )),
      shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent)
    )
  ),
  cardColor: Colors.grey[300],
  scaffoldBackgroundColor: lightColorScheme.surface,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent
  ),
  iconTheme: const IconThemeData(
    color: Colors.grey
  ),

  // cupertino
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
    primaryContrastingColor: Colors.blue[100]
  )
);