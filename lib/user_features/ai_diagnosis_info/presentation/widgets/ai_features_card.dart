import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AiFeaturesCard extends StatelessWidget {
  const AiFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.speed_outlined,
        'title': 'تشخيص فوري',
        'description': 'نتائج في أقل من 30 ثانية',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.precision_manufacturing_outlined,
        'title': 'دقة عالية',
        'description': 'دقة تصل إلى 95% في التشخيص',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.security_outlined,
        'title': 'خصوصية تامة',
        'description': 'حماية كاملة لبياناتك الطبية',
        'color': AppColors.tertiary,
      },
      {
        'icon': Icons.history_outlined,
        'title': 'سجل التشخيصات',
        'description': 'تتبع تاريخك الطبي بسهولة',
        'color': AppColors.quaternary,
      },
      {
        'icon': Icons.psychology_outlined,
        'title': 'ذكاء متطور',
        'description': 'خوارزميات تعلم آلي متقدمة',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.support_agent_outlined,
        'title': 'دعم طبي',
        'description': 'نصائح وتوجيهات من خبراء',
        'color': AppColors.secondary,
      },
    ];

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            childAspectRatio: 1 / 1.2,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];

            return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (feature['color'] as Color).withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (feature['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          color: feature['color'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        feature['title'] as String,
                        style: getBoldStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature['description'] as String,
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(
                  duration: 600.ms,
                  delay: Duration(milliseconds: 100 * index),
                )
                .scale(begin: const Offset(0.5, 0.5));
          },
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideX(begin: 0.1);
  }
}
