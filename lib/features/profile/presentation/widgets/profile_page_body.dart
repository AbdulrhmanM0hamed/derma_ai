import 'package:derma_ai/core/utils/animations/app_animations.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:derma_ai/features/profile/presentation/widgets/profile_menu_item_widget.dart';
import 'package:derma_ai/features/profile/presentation/widgets/profile_stats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileHeaderWidget(),
          const SizedBox(height: 24),
          const ProfileStatsWidget(),
          const SizedBox(height: 24),
          _buildMenuItems(context),
          const SizedBox(height: 24),
          _buildLogoutButton(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ProfileMenuItemWidget(
            icon: Icons.person_outline,
            title: 'معلوماتي الشخصية',
            onTap: () {
              // TODO: Navigate to my info
            },
          ),
          ProfileMenuItemWidget(
            icon: Icons.history_outlined,
            title: 'سجل التشخيصات',
            onTap: () {
              // TODO: Navigate to diagnosis history
            },
          ),
          ProfileMenuItemWidget(
            icon: Icons.payment_outlined,
            title: 'طرق الدفع',
            onTap: () {
              // TODO: Navigate to payment methods
            },
          ),
          ProfileMenuItemWidget(
            icon: Icons.help_outline,
            title: 'المساعدة والدعم',
            onTap: () {
              // TODO: Navigate to help & support
            },
          ),
          ProfileMenuItemWidget(
            icon: Icons.privacy_tip_outlined,
            title: 'سياسة الخصوصية',
            onTap: () {
              // TODO: Navigate to privacy policy
            },
          ),
        ],
      ),
    ).animate(effects: fadeIn(duration: 300.ms, delay: 400.ms));
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        text: 'تسجيل الخروج',
        onPressed: () => _showLogoutDialog(context),
        type: ButtonType.outline,
        width: double.infinity,
        height: 56,
        icon: Icons.logout,
      ),
    ).animate(effects: fadeIn(duration: 300.ms, delay: 500.ms));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تسجيل الخروج',
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontFamily: FontConstant.cairo,
          ),
        ),
        content: Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: getSemiBoldStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement logout logic and navigation
            },
            child: Text(
              'خروج',
              style: getSemiBoldStyle(
                color: AppColors.error,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
