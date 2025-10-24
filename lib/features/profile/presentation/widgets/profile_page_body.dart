import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/helper/on_genrated_routes.dart';
import 'package:derma_ai/core/utils/animations/app_animations.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/widgets/custom_snackbar.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:derma_ai/features/auth/presentation/bloc/auth_state.dart';
import 'package:derma_ai/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:derma_ai/features/profile/presentation/widgets/profile_menu_item_widget.dart';
import 'package:derma_ai/features/profile/presentation/widgets/profile_stats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          // Optionally show a loading indicator that covers the screen
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => const Center(child: CustomProgressIndicator()),
          );
        } else if (state is LogoutSuccess) {
          CustomSnackbar.showSuccess(
            context: context,
            message: CustomSnackbar.getLocalizedMessage(
              context: context,
              messageAr: state.messageAr,
              messageEn: state.messageEn,
            ),
          );
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        } else if (state is LogoutFailure) {
          Navigator.of(context).pop(); // Dismiss loading dialog
          CustomSnackbar.showError(
            context: context,
            message: CustomSnackbar.getLocalizedMessage(
              context: context,
              messageAr: state.messageAr,
              messageEn: state.messageEn,
            ),
          );
        }
      },
      child: SingleChildScrollView(
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
        width: double.infinity,
        height: 56,
        icon: const Icon(Icons.logout),
      ),
    ).animate(effects: fadeIn(duration: 300.ms, delay: 500.ms));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
                  Navigator.of(context).pop(); // Close the dialog
                  context.read<AuthCubit>().logout();
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
