import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A professional form card container for auth pages
class AuthFormCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AuthFormCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.zero,
      elevation: isDark ? 0 : 8,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: isDark
            ? BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              )
            : BorderSide.none,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(24),
        child: child,
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 500.ms).slideY(begin: 0.15);
  }
}
