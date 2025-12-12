import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/theme/app_colors.dart';

/// Enum to define user types for auth pages
enum UserType { user, doctor }

/// A professional header widget for auth pages with animated logo
class AuthHeader extends StatelessWidget {
  final UserType selectedUserType;
  final String title;
  final String subtitle;
  final String userSvgAsset;
  final String doctorSvgAsset;

  const AuthHeader({
    super.key,
    required this.selectedUserType,
    required this.title,
    required this.subtitle,
    this.userSvgAsset = 'assets/images/user_login.svg',
    this.doctorSvgAsset = 'assets/images/doctor_login.svg',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Animated Logo Container
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.15),
                AppColors.primary.withValues(alpha: isDark ? 0.05 : 0.05),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: isDark ? 0.3 : 0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
              ),
              // Inner content
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: SvgPicture.asset(
                  selectedUserType == UserType.doctor
                      ? doctorSvgAsset
                      : userSvgAsset,
                  key: ValueKey(selectedUserType),
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.8, 0.8), duration: 600.ms),

        const SizedBox(height: 28),

        // Title
        Text(
          title,
          style: getBoldStyle(
            color: isDark ? Colors.white : AppColors.textPrimary,
            fontSize: 26,
            fontFamily: FontConstant.cairo,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          subtitle,
          style: getRegularStyle(
            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
            fontSize: 15,
            fontFamily: FontConstant.cairo,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
      ],
    );
  }
}
