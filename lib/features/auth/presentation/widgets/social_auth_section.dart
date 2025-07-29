import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(context)
            .animate()
            .fadeIn(duration: 600.ms, delay: 800.ms),
        const SizedBox(height: 24),
        _buildSocialLogin()
            .animate()
            .fadeIn(duration: 600.ms, delay: 900.ms),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppLocalizations.of(context)!.orContinueWith,
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: 'assets/icons/google_icon.svg',
          onPressed: () {
            // TODO: Implement Google Sign In
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: 'assets/icons/facebook_icon.svg',
          onPressed: () {
            // TODO: Implement Facebook Sign In
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: 'assets/icons/apple_icon.svg',
          onPressed: () {
            // TODO: Implement Apple Sign In
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: SvgPicture.asset(icon)),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(
          begin: 1,
          end: 1.05,
          duration: 2000.ms,
          curve: Curves.easeInOut,
        );
  }
}
