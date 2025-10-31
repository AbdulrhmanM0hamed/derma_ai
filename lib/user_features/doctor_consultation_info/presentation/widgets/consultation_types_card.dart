import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ConsultationTypesCard extends StatelessWidget {
  const ConsultationTypesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final consultationTypes = [
      {
        'icon': Icons.video_call_outlined,
        'title': 'استشارة مرئية',
        'description': 'مكالمة فيديو مباشرة مع الطبيب',
        'duration': '30-45 دقيقة',
        'color': AppColors.primary,
        'features': ['فحص مرئي مباشر', 'تشخيص فوري', 'وصفة طبية'],
      },
      {
        'icon': Icons.phone_outlined,
        'title': 'استشارة صوتية',
        'description': 'مكالمة صوتية مع الطبيب المختص',
        'duration': '20-30 دقيقة',
        'color': AppColors.secondary,
        'features': ['استشارة سريعة', 'نصائح طبية', 'متابعة العلاج'],
      },
      {
        'icon': Icons.message_outlined,
        'title': 'استشارة نصية',
        'description': 'محادثة نصية مع إرسال الصور',
        'duration': '24 ساعة رد',
        'color': AppColors.third,
        'features': ['مرونة في التوقيت', 'إرسال صور', 'تقرير مكتوب'],
      },
      {
        'icon': Icons.local_hospital_outlined,
        'title': 'زيارة عيادة',
        'description': 'حجز موعد في عيادة الطبيب',
        'duration': '45-60 دقيقة',
        'color': AppColors.quaternary,
        'features': ['فحص شامل', 'تحاليل مخبرية', 'متابعة دورية'],
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.03),
            AppColors.secondary.withValues(alpha: 0.03),
            AppColors.third.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: consultationTypes.asMap().entries.map((entry) {
          final index = entry.key;
          final type = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: (type['color'] as Color).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (type['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        type['icon'] as IconData,
                        color: type['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type['title'] as String,
                            style: getBoldStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            type['description'] as String,
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: (type['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        type['duration'] as String,
                        style: getRegularStyle(
                          color: type['color'] as Color,
                          fontSize: 11,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Features
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (type['features'] as List<String>).map((feature) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: (type['color'] as Color).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: (type['color'] as Color).withValues(alpha: 0.2),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: type['color'] as Color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            feature,
                            style: getRegularStyle(
                              color: type['color'] as Color,
                              fontSize: 12,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ).animate().fadeIn(
            duration: 600.ms,
            delay: Duration(milliseconds: 150 * index),
          ).slideX(begin: -0.1);
        }).toList(),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1);
  }
}
