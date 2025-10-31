import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AiHowItWorksCard extends StatelessWidget {
  const AiHowItWorksCard({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'icon': Icons.camera_alt_outlined,
        'title': 'التقط صورة',
        'description': 'قم بتصوير المنطقة المصابة بوضوح',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.auto_awesome_outlined,
        'title': 'تحليل ذكي',
        'description': 'يحلل الذكاء الاصطناعي الصورة فوراً',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.medical_information_outlined,
        'title': 'نتائج دقيقة',
        'description': 'احصل على تشخيص مفصل ونصائح',
        'color': AppColors.tertiary,
      },
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: -0.1);
  }
}
