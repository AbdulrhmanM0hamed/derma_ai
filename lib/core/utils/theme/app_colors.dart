import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1295CC); // Azure Blue
  // Off White
  static const Color secondary = Color.fromARGB(
    255,
    40,
    243,
    202,
  ); // Medical Deep Teal

  static const Color tertiary = Color.fromARGB(
    255,
    8,
    150,
    194,
  ); // Teal for Skin Care
  static const Color third = Color(0xFFF2F7FB);
  static const Color quaternary = Colors.orange; // Orange for Health Tips
  // static const Color primary = Color(0xFF6EC1E4); // Sky Blue
  // static const Color secondary = Color(0xFFFDEFF2); // Very Pale Pink
  // static const Color third = Color(0xFFFFCCD5); // Soft Rose
  // static const Color primary = Color.fromARGB(255, 1, 126, 148);
  // static const Color secondary = Color(0xFF0085A3);
  // static const Color third = Color(0xFF7DD3FC);
  // static const Color primary = Color(0xFF5C16EA);
  // static const Color secondary = Color(0xFF7D44ED);
  // static const Color third = Color(0xFFCEB8F8);
  // Background Colors
  static const Color scaffoldBackground = Colors.white;
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF263643);
  static const Color textSecondary = Color.fromARGB(255, 166, 174, 182);
  static const Color textLight = Colors.white;
  static const Color textLight70 = Colors.white60;
  static const Color black = Color.fromARGB(255, 0, 0, 0);

  static const List<Color> primaryGradient = [
    Color(0xFF005F73),
    Color(0xFF3F8EFC),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF005F73),
    Color.fromARGB(255, 145, 196, 229),
  ];

  static const List<Color> lightGradient = [
    Color.fromARGB(255, 55, 160, 230),
    Color(0xFFF0F9FF),
  ];

  static const List<Color> medicalGradient = [
    Color(0xFF3F8EFC), // Azure Blue
    Color(0xFF2A7CC1), // Mid Blue (بين الأزرقين)
    Color(0xFF005F73), // Deep Teal
  ];

  // Status Colors
  static const Color success = Color(0xFF28A745);
  static const Color error = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF17A2B8);
  static const Color shadow = Color(0xFF000000);
  static const Color shadowLight = Color(0xFF000000);

  // Border Colors
  static const Color border = Color.fromARGB(255, 202, 202, 202);
  static const Color divider = Color.fromARGB(34, 225, 225, 225);
  static const Color grey = Colors.grey;

  // Rating Colors
  static const Color starActive = Color(0xFFFFBC57);
  static const Color starInactive = Color(0xFFD1D1D1);

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color white = Color.fromARGB(255, 255, 255, 255);

  static Color getContainerBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]! // لون داكن للوضع الليلي
        : Colors.grey[100]!; // لون فاتح للوضع النهاري
  }
}
