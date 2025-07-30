import 'package:flutter/material.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/dummy_health_tips_data.dart';
import 'article_card.dart';
import 'daily_tip_card.dart';
import 'disease_info_card.dart';

class HealthTipsBody extends StatelessWidget {
  const HealthTipsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily tip section
          Text(
            'نصيحة اليوم',
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 16),
          const DailyTipCard(),
          
          const SizedBox(height: 24),
          
          // Articles section
          Text(
            'مقالات طبية',
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 16),
          // Dynamically create ArticleCards
          ...dummyArticles.asMap().entries.map((entry) {
            final index = entry.key;
            final article = entry.value;
            return ArticleCard(article: article, index: index);
          }),
          
          const SizedBox(height: 24),
          
          // Disease info section
          Text(
            'معلومات عن الأمراض الجلدية',
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 16),
          // Dynamically create DiseaseInfoCards
          ...dummyDiseases.asMap().entries.map((entry) {
            final index = entry.key;
            final disease = entry.value;
            return DiseaseInfoCard(disease: disease, index: index);
          }),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
