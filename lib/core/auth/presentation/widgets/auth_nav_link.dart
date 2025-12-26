import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/theme/app_colors.dart';

/// A theme-aware navigation link for auth pages (e.g., "Don't have account? Sign up")
class AuthNavLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onLinkTap;

  const AuthNavLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: getRegularStyle(
            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onLinkTap();
          },
          child: Text(
            linkText,
            style: getSemiBoldStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ),
      ],
    );
  }
}
