import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/animations/app_animations.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withValues(alpha:0.5),
              blurRadius: 8,
              spreadRadius: -2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: color.withValues(alpha:0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ).animate(effects: pulse(
              duration: 2000.ms,
              begin: 1,
              end: 1.05,
            )).animate(onPlay: (controller) => controller.repeat(reverse: true)),
            const SizedBox(height: 8),
            Text(
              title,
              style: getSemiBoldStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).scale(delay: 100.ms),
    );
  }
}