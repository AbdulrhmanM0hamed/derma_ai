import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AiBenefitsCard extends StatelessWidget {
  const AiBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      {
        'icon': Icons.access_time_outlined,
        'title': 'توفير الوقت',
        'description': 'لا حاجة لانتظار مواعيد الأطباء للحصول على تشخيص أولي',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.savings_outlined,
        'title': 'توفير التكاليف',
        'description': 'تجنب تكاليف الزيارات غير الضرورية للعيادات',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.home_outlined,
        'title': 'راحة المنزل',
        'description': 'احصل على التشخيص من راحة منزلك دون الحاجة للسفر',
        'color': AppColors.tertiary,
      },
      {
        'icon': Icons.psychology_outlined,
        'title': 'تقنية متطورة',
        'description': 'استفد من أحدث تقنيات الذكاء الاصطناعي في الطب',
        'color': AppColors.quaternary,
      },
      {
        'icon': Icons.verified_user_outlined,
        'title': 'موثوقية عالية',
        'description': 'نتائج مدعومة بدراسات علمية وخبرة طبية واسعة',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.support_outlined,
        'title': 'دعم مستمر',
        'description': 'فريق طبي متخصص متاح للاستشارة والمتابعة',
        'color': AppColors.secondary,
      },
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
     
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.tertiary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.star_outline,
                    color: AppColors.tertiary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'لماذا تختار التشخيص الذكي؟',
                  style: getBoldStyle(
                  
                    fontSize: 18,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Benefits list
            Column(
              children: benefits.asMap().entries.map((entry) {
                final index = entry.key;
                final benefit = entry.value;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (benefit['color'] as Color).withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (benefit['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          benefit['icon'] as IconData,
                          color: benefit['color'] as Color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              benefit['title'] as String,
                              style: getBoldStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              benefit['description'] as String,
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
                ).animate().fadeIn(
                  duration: 600.ms,
                  delay: Duration(milliseconds: 100 * index),
                ).slideX(begin: -0.1);
              }).toList(),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).slideY(begin: 0.1);
  }
}
