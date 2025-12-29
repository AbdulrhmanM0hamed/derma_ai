import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../ai_diagnosis/presentation/widgets/diagnosis_card.dart';
import '../../data/home_dummy_data.dart';

class HomeRecentDiagnosesSection extends StatelessWidget {
  const HomeRecentDiagnosesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recentDiagnoses = HomeDummyData.getRecentDiagnoses();

    if (recentDiagnoses.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.recentDiagnoses,
              style: getBoldStyle(
       
                fontSize: 22,
                fontFamily: FontConstant.cairo,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all diagnoses
              },
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: getSemiBoldStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentDiagnoses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final diagnosis = recentDiagnoses[index];
            return Animate(
              effects: fadeInSlide(
                duration: 300.ms,
                delay: Duration(milliseconds: 100 * index),
                beginY: 0.1,
              ),
              child: DiagnosisCard(
                diagnosis: diagnosis,
                onTap: () {
                  // Navigate to diagnosis details
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
