import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionPressed;

  const AuthFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: fadeIn(
        duration: 300.ms,
        delay: 700.ms,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionText,
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(width: 4),
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionText,
              style: getSemiBoldStyle(
                color: AppColors.primary,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
