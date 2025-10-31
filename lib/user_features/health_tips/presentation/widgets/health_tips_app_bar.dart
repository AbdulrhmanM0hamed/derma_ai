import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class HealthTipsAppBar extends StatelessWidget {
  const HealthTipsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.quaternary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocalizations.of(context)!.healthTips,
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
                AppColors.quaternary,
                AppColors.quaternary.withValues(alpha: 0.8),
                AppColors.quaternary.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                ).animate().scale(delay: 200.ms, duration: 800.ms),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.08),
                    shape: BoxShape.circle,
                  ),
                ).animate().scale(delay: 400.ms, duration: 800.ms),
              ),
              // Main icon
              Positioned(
                bottom: 70,
                left: 40,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
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
