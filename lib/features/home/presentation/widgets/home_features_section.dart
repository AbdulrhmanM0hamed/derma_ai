import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import 'feature_card.dart';

class HomeFeaturesSection extends StatelessWidget {
  const HomeFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'title': AppLocalizations.of(context)!.aiDiagnosis,
        'icon': Icons.auto_awesome_outlined,
        'color': AppColors.primary,
        'onTap': () {
          // Navigate to AI diagnosis
        },
      },
      {
        'title': AppLocalizations.of(context)!.doctorConsultation,
        'icon': Icons.medical_services_outlined,
        'color': const Color.fromARGB(255, 115, 182, 238),
        'onTap': () {
          // Navigate to doctor consultation
        },
      },
      {
        'title': AppLocalizations.of(context)!.skinCare,
        'icon': Icons.spa_outlined,
        'color': const Color.fromARGB(255, 8, 150, 194),
        'onTap': () {
          // Navigate to skin care
        },
      },
      {
        'title': AppLocalizations.of(context)!.healthTips,
        'icon': Icons.lightbulb_outline,
        'color': Colors.orange,
        'onTap': () {
          // Navigate to health tips
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.ourServices,
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontFamily: FontConstant.cairo,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          padding:  EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return Animate(
              effects: fadeInSlide(
                duration: 300.ms,
                delay: Duration(milliseconds: 100 * index),
                beginY: 0.1,
              ),
              child: FeatureCard(
                title: feature['title'] as String,
                icon: feature['icon'] as IconData,
                color: feature['color'] as Color,
                onTap: feature['onTap'] as VoidCallback,
              ),
            );
          },
        ),
      ],
    );
  }
}
