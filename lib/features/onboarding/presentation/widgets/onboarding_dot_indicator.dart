import 'package:flutter/material.dart';




class OnboardingDotIndicator extends StatelessWidget {
  final bool isActive;
  final int index;

  const OnboardingDotIndicator({
    super.key,
    required this.isActive,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: isActive ? 32 : 12,
      height: 12,
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withValues(alpha: 0.9),
                ],
              )
            : null,
        color: isActive ? null : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
