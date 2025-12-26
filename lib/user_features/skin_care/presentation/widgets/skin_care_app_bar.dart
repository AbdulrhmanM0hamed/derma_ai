import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SkinCareAppBar extends StatelessWidget {
  const SkinCareAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.secondary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocalizations.of(context)!.skinCare,
          style: getBoldStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: FontConstant.cairo,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondary,
                AppColors.secondary.withValues(alpha: 0.8),
                AppColors.secondary.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: 50,
                right: 30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:.1),
                    shape: BoxShape.circle,
                  ),
                ).animate().scale(delay: 200.ms, duration: 800.ms),
              ),
              Positioned(
                top: 120,
                left: 40,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:.08),
                    shape: BoxShape.circle,
                  ),
                ).animate().scale(delay: 400.ms, duration: 800.ms),
              ),
              // Main icon
              Positioned(
                bottom: 60,
                right: 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.spa_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ).animate().fadeIn(delay: 600.ms).scale(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
