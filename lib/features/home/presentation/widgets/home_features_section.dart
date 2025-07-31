import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import 'package:derma_ai/features/ai_diagnosis/presentation/pages/ai_diagnosis_page.dart';
import 'package:derma_ai/features/doctor_search_and_browse/doctor_search_and_browse.dart';
import 'package:derma_ai/features/health_tips/presentation/pages/health_tips_page.dart';
import 'package:derma_ai/features/skin_care/presentation/pages/skin_care_page.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AiDiagnosisPage()),
          );
        },
      },
      {
        'title': AppLocalizations.of(context)!.doctorConsultation,
        'icon': Icons.medical_services_outlined,
        'color': AppColors.third,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DoctorSearchAndBrowse(),
            ),
          );
        },
      },
      {
        'title': AppLocalizations.of(context)!.skinCare,
        'icon': Icons.spa_outlined,
        'color': const Color.fromARGB(255, 11, 167, 214),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SkinCarePage()),
          );
        },
      },
      {
        'title': AppLocalizations.of(context)!.healthTips,
        'icon': Icons.lightbulb_outline,
        'color': AppColors.quaternary,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HealthTipsPage()),
          );
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
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
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
