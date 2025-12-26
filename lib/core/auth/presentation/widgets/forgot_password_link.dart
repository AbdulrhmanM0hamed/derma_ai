import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/theme/app_colors.dart';

/// A theme-aware forgot password link
class ForgotPasswordLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ForgotPasswordLink({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Text(
        text,
        style: getMediumStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontFamily: FontConstant.cairo,
        ),
      ),
    );
  }
}
