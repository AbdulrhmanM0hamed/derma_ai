import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import 'skin_type_card.dart';
import 'daily_routine_card.dart';
import 'product_recommendation_card.dart';
import 'skin_care_tips_section.dart';

class SkinCareBody extends StatelessWidget {
  const SkinCareBody({super.key});

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
                colors: AppColors.lightGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha:.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اكتشف روتين العناية المثالي لبشرتك',
                  style: getBoldStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'نصائح مخصصة وروتين يومي للحصول على بشرة صحية ومشرقة',
                  style: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          // Skin types section
          Text(
            'أنواع البشرة',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),

          const SkinTypeCard(),

          const SizedBox(height: 16),

          // Daily routine section
          Text(
            'الروتين اليومي',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),

          const DailyRoutineCard(),

          const SizedBox(height: 16),

          // Product recommendations
          Text(
            'منتجات مقترحة',
            style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
          ),
          const SizedBox(height: 16),

          const ProductRecommendationCard(),

          const SizedBox(height: 24),

          // Skin care tips
          const SkinCareTipsSection(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
