import 'package:flutter/material.dart';

extension ColorX on Color {
  Color faded(double opacity) => withValues(alpha: opacity);
  Color blendWith(Color other, [double opacity = 0.3]) =>
      Color.alphaBlend(withValues(alpha: opacity), other);
}
