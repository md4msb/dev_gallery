import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle get heading => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );

  static TextStyle get title =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get body =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get caption =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
}
