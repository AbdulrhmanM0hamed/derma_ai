import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ConsultationBenefitsCard extends StatelessWidget {
  const ConsultationBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      {
        'icon': Icons.verified_user_outlined,
        'title': 'أطباء معتمدون',
        'description':
            'جميع الأطباء حاصلون على شهادات معتمدة وخبرة واسعة في التخصص',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.schedule_outlined,
        'title': 'مرونة في المواعيد',
        'description': 'احجز في أي وقت يناسبك، حتى في المساء وأيام العطل',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.security_outlined,
        'title': 'خصوصية تامة',
        'description': 'جميع المعلومات الطبية محمية ومشفرة بأعلى معايير الأمان',
        'color': AppColors.grey,
      },
      {
        'icon': Icons.support_agent_outlined,
        'title': 'دعم فني 24/7',
        'description': 'فريق الدعم الفني متاح على مدار الساعة لمساعدتك',
        'color': AppColors.quaternary,
      },
      {
        'icon': Icons.history_outlined,
        'title': 'سجل طبي شامل',
        'description': 'احتفظ بجميع استشاراتك وتقاريرك الطبية في مكان واحد',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.notifications_active_outlined,
        'title': 'تذكير بالمواعيد',
        'description': 'تنبيهات تلقائية لتذكيرك بمواعيد الاستشارات والأدوية',
        'color': AppColors.secondary,
      },
      {
        'icon': Icons.star_outlined,
        'title': 'تقييم الأطباء',
        'description': 'اختر الطبيب المناسب بناءً على تقييمات المرضى الآخرين',
        'color': AppColors.textSecondary,
      },
      {
        'icon': Icons.language_outlined,
        'title': 'دعم متعدد اللغات',
        'description': 'أطباء يتحدثون العربية والإنجليزية لراحتك التامة',
        'color': AppColors.quaternary,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.03),
            AppColors.third.withValues(alpha: 0.03),
            AppColors.quaternary.withValues(alpha: 0.03),
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
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.workspace_premium_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'لماذا تختار استشاراتنا الطبية؟',
                style: getBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Benefits grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: benefits.length,
            itemBuilder: (context, index) {
              final benefit = benefits[index];

              return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (benefit['color'] as Color).withValues(
                          alpha: 0.1,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (benefit['color'] as Color).withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            benefit['icon'] as IconData,
                            color: benefit['color'] as Color,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          benefit['title'] as String,
                          style: getBoldStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Expanded(
                          child: Text(
                            benefit['description'] as String,
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontFamily: FontConstant.cairo,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
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
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).slideY(begin: 0.1);
  }
}
