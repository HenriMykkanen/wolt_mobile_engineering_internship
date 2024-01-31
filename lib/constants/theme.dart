import 'package:flutter/material.dart';

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    iconTheme: const IconThemeData(size: 30, color: Colors.black87),
    textTheme: Theme.of(context).textTheme.copyWith(
        // Disclaimers
        displayLarge: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        // For titles
        displayMedium: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: Color.fromRGBO(76, 77, 79, 1)),
        // Mainly for small descriptions
        displaySmall: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.3,
            color: Color.fromRGBO(93, 94, 96, 1))),
  );
}
