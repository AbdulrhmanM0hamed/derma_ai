import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? logo;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (logo != null) ...[
          Animate(
            effects: fadeInScaleUp(
              duration: 300.ms,
              begin: 0.8,
            ),
            child: logo!,
          ),
          const SizedBox(height: 24),
        ],
        Animate(
          effects: fadeInSlide(
            duration: 300.ms,
            delay: 100.ms,
            beginY: 0.2,
          ),
          child: Text(
            title,
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Animate(
            effects: fadeInSlide(
              duration: 300.ms,
              delay: 200.ms,
              beginY: 0.2,
            ),
            child: Text(
              subtitle!,
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}
