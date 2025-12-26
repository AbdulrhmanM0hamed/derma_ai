import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../ai_diagnosis/presentation/pages/ai_diagnosis_page.dart';
import 'ai_features_card.dart';
import 'ai_how_it_works_card.dart';
import 'ai_benefits_card.dart';
import 'ai_accuracy_stats_card.dart';

class AiDiagnosisInfoBody extends StatelessWidget {
  const AiDiagnosisInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.05),
                  AppColors.secondary.withValues(alpha: 0.05),
                  AppColors.primary.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'تشخيص ذكي ودقيق للأمراض الجلدية',
                        style: getBoldStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'استخدم تقنية الذكاء الاصطناعي المتقدمة للحصول على تشخيص فوري ودقيق للحالات الجلدية من خلال تحليل الصور بدقة عالية',
                  style: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AiDiagnosisPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'ابدأ التشخيص الآن',
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          // How it works section
          Text(
            'كيف يعمل التشخيص الذكي؟',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const AiHowItWorksCard(),

          const SizedBox(height: 24),

          // Features section
          Text(
            'المميزات الرئيسية',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const AiFeaturesCard(),

          const SizedBox(height: 24),

          // Accuracy stats
          Text(
            'إحصائيات الدقة',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const AiAccuracyStatsCard(),

          const SizedBox(height: 24),

          // Benefits section
          Text(
            'الفوائد والمزايا',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const AiBenefitsCard(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
