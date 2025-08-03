import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../doctor_booking/presentation/widgets/doctor_card.dart';
import '../data/home_dummy_data.dart';

class HomeTopDoctorsSection extends StatelessWidget {
  const HomeTopDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final topDoctors = HomeDummyData.getTopDoctors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.topDermatologists,
              style: getBoldStyle(fontSize: 22, fontFamily: FontConstant.cairo),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all doctors
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
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: topDoctors.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final doctor = topDoctors[index];
            return Animate(
              effects: fadeInSlide(
                duration: 300.ms,
                delay: Duration(milliseconds: 100 * index),
                beginY: 0.1,
              ),
              child: DoctorCard(
                doctor: doctor,
                heroTagSuffix: "_home",
                onTap: () {
                  // Navigate to doctor details
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
