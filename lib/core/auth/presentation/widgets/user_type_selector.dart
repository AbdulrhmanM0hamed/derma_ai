import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/theme/app_colors.dart';
import 'auth_header.dart';

/// A professional user type selector widget (User/Doctor toggle)
class UserTypeSelector extends StatelessWidget {
  final UserType selectedUserType;
  final String userLabel;
  final String doctorLabel;
  final ValueChanged<UserType> onUserTypeChanged;

  const UserTypeSelector({
    super.key,
    required this.selectedUserType,
    required this.userLabel,
    required this.doctorLabel,
    required this.onUserTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onUserTypeChanged(
          selectedUserType == UserType.user ? UserType.doctor : UserType.user,
        );
      },
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.secondary.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Animated background slider
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              alignment: selectedUserType == UserType.user
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: Container(
                width: (screenWidth - 48 - 40) / 2,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
            // User and Doctor labels
            Row(
              children: [
                Expanded(
                  child: _buildOption(
                    context: context,
                    icon: Icons.person_rounded,
                    label: userLabel,
                    isSelected: selectedUserType == UserType.user,
                    isDark: isDark,
                  ),
                ),
                Expanded(
                  child: _buildOption(
                    context: context,
                    icon: Icons.medical_services_rounded,
                    label: doctorLabel,
                    isSelected: selectedUserType == UserType.doctor,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2);
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey[400] : AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            style: getSemiBoldStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey[400] : AppColors.textSecondary),
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
