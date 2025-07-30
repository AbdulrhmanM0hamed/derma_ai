import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class AiFeatureCard extends StatelessWidget {
  const AiFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     
        const SizedBox(height: 8),
        Animate(
          effects: fadeInScaleUp(
            duration: 400.ms,
            delay: 200.ms,
            begin: 0.95,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              
              gradient: const LinearGradient(
                colors: AppColors.medicalGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha:0.25),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha:0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.aiSkinDiagnosis,
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.diagnosisDescription,
                        style: getRegularStyle(
                          color: Colors.white.withValues(alpha:0.9),
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: AppLocalizations.of(context)!.startDiagnosis,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.diagnosis);
                        },
                      
                        icon: Icons.camera_alt_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.document_scanner_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
