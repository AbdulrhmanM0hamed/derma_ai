import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ConsultationPricingCard extends StatelessWidget {
  const ConsultationPricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final pricingPlans = [
      {
        'type': 'استشارة نصية',
        'price': '50',
        'originalPrice': '70',
        'duration': '24 ساعة رد',
        'color': AppColors.primary,
        'popular': false,
        'features': [
          'محادثة نصية مع الطبيب',
          'إرسال الصور والتقارير',
          'رد خلال 24 ساعة',
          'تقرير طبي مكتوب',
        ],
      },
      {
        'type': 'استشارة صوتية',
        'price': '100',
        'originalPrice': '130',
        'duration': '20-30 دقيقة',
        'color': AppColors.secondary,
        'popular': true,
        'features': [
          'مكالمة صوتية مباشرة',
          'استشارة فورية',
          'نصائح طبية شخصية',
          'تسجيل المكالمة',
        ],
      },
      {
        'type': 'استشارة مرئية',
        'price': '150',
        'originalPrice': '200',
        'duration': '30-45 دقيقة',
        'color': AppColors.third,
        'popular': false,
        'features': [
          'مكالمة فيديو مباشرة',
          'فحص مرئي دقيق',
          'تشخيص شامل',
          'وصفة طبية فورية',
        ],
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.quaternary.withValues(alpha: 0.03),
            AppColors.primary.withValues(alpha: 0.03),
            AppColors.secondary.withValues(alpha: 0.03),
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
                  color: AppColors.quaternary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: AppColors.quaternary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'أسعار تنافسية وعروض خاصة',
                style: getBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Pricing cards
          Column(
            children: pricingPlans.asMap().entries.map((entry) {
              final index = entry.key;
              final plan = entry.value;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: plan['popular'] as bool
                        ? (plan['color'] as Color)
                        : (plan['color'] as Color).withValues(alpha: 0.2),
                    width: plan['popular'] as bool ? 2 : 1,
                  ),
                ),
                child: Stack(
                  children: [
                    // Popular badge
                    if (plan['popular'] as bool)
                      Positioned(
                        top: -8,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: plan['color'] as Color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'الأكثر طلباً',
                            style: getBoldStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                      ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan['type'] as String,
                                  style: getBoldStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 18,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  plan['duration'] as String,
                                  style: getRegularStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${plan['originalPrice']} ر.س',
                                      style: getRegularStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                        fontFamily: FontConstant.cairo,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${plan['price']} ر.س',
                                      style: getBoldStyle(
                                        color: plan['color'] as Color,
                                        fontSize: 20,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'خصم 30%',
                                    style: getRegularStyle(
                                      color: Colors.green,
                                      fontSize: 11,
                                      fontFamily: FontConstant.cairo,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Features
                        Column(
                          children: (plan['features'] as List<String>).map((feature) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: plan['color'] as Color,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: getRegularStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(
                duration: 600.ms,
                delay: Duration(milliseconds: 150 * index),
              ).slideX(begin: 0.1);
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.1);
  }
}
