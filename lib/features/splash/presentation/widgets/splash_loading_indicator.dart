import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    ).animate(effects: fadeIn(
      duration: 400.ms,
      delay: 600.ms,
    ));
  }
}
