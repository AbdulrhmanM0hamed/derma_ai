import 'package:derma_ai/core/utils/theme/app_colors.dart';
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
                  AppColors.primary,
                  AppColors.primary,
                ],
              )
            : null,
        color: isActive ? null : AppColors.primary.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
