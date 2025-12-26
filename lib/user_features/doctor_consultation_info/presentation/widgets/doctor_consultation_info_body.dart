import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../doctor_search_and_browse/doctor_search_and_browse.dart';
import 'consultation_types_card.dart';
import 'consultation_process_card.dart';
import 'consultation_benefits_card.dart';
import 'consultation_pricing_card.dart';

class DoctorConsultationInfoBody extends StatelessWidget {
  const DoctorConsultationInfoBody({super.key});

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
                  AppColors.tertiary.withValues(alpha: 0.05),
                  AppColors.tertiary.withValues(alpha: 0.03),
                  AppColors.tertiary.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.tertiary.withValues(alpha: 0.1),
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
                        color: AppColors.tertiary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.medical_services,
                        color: AppColors.tertiary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'استشارة طبية متخصصة ومباشرة',
                        style: getBoldStyle(
                          color: AppColors.tertiary,
                          fontSize: 18,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'احصل على استشارة طبية من أطباء جلدية متخصصين ومعتمدين، مع إمكانية الحجز الفوري والمتابعة المستمرة لحالتك الصحية',
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
                          builder: (context) => const DoctorSearchAndBrowse(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
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
                        Icon(Icons.search_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'ابحث عن طبيب الآن',
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

          // Consultation types section
          Text(
            'أنواع الاستشارات المتاحة',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const ConsultationTypesCard(),

          const SizedBox(height: 24),

          // Process section
          Text(
            'كيف تتم الاستشارة؟',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const ConsultationProcessCard(),

          const SizedBox(height: 24),

          // Pricing section
          Text(
            'أسعار الاستشارات',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const ConsultationPricingCard(),

          const SizedBox(height: 24),

          // Benefits section
          Text(
            'مميزات الاستشارة الطبية',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),
          const ConsultationBenefitsCard(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
