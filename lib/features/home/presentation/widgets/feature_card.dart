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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
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
              style: getMediumStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ).animate(effects: cardSelection(
        duration: 200.ms,
        scaleBegin: const Offset(1, 1),
        scaleEnd: const Offset(0.95, 0.95),
        color: color,
      )),
    );
  }
}