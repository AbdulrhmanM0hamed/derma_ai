import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ConsultationProcessCard extends StatelessWidget {
  const ConsultationProcessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'icon': Icons.search_outlined,
        'title': 'اختر الطبيب',
        'description': 'ابحث واختر الطبيب المناسب حسب التخصص والتقييمات',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'احجز موعد',
        'description': 'اختر الوقت المناسب لك من الأوقات المتاحة',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.payment_outlined,
        'title': 'ادفع بأمان',
        'description': 'ادفع رسوم الاستشارة بطريقة آمنة ومضمونة',
        'color': AppColors.grey,
      },
      {
        'icon': Icons.video_call_outlined,
        'title': 'ابدأ الاستشارة',
        'description': 'تواصل مع الطبيب في الوقت المحدد واحصل على التشخيص',
        'color': AppColors.quaternary,
      },
      {
        'icon': Icons.description_outlined,
        'title': 'احصل على التقرير',
        'description': 'استلم تقرير مفصل مع الوصفة الطبية والتوصيات',
        'color': AppColors.primary,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
        children:
            steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;

              return Column(
                children: [
                  Row(
                    children: [
                      // Step number
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (step['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: getBoldStyle(
                              color: step['color'] as Color,
                              fontSize: 16,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (step['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          step['icon'] as IconData,
                          color: step['color'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step['title'] as String,
                              style: getBoldStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step['description'] as String,
                              style: getRegularStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (index < steps.length - 1) ...[
                    const SizedBox(height: 20),
                    // Connecting line
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  (step['color'] as Color).withValues(
                                    alpha: 0.3,
                                  ),
                                  (steps[index + 1]['color'] as Color)
                                      .withValues(alpha: 0.3),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.5,
                            ),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              );
            }).toList(),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideX(begin: 0.1);
  }
}
