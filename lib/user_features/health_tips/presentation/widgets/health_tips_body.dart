import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/dummy_health_tips_data.dart';
import '../bloc/health_tips_cubit.dart';
import '../bloc/health_tips_state.dart';
import 'article_card.dart';
import 'daily_tip_card.dart';
import 'disease_info_card.dart';

class HealthTipsBody extends StatefulWidget {
  const HealthTipsBody({super.key});

  @override
  State<HealthTipsBody> createState() => _HealthTipsBodyState();
}

class _HealthTipsBodyState extends State<HealthTipsBody> {
  @override
  void initState() {
    super.initState();
    // تحميل آخر نصيحة عند بدء الـ widget
    context.read<HealthTipsCubit>().getLatestTip();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily tip section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'نصيحة اليوم',
                style: getBoldStyle(
                  fontSize: 20,
                  fontFamily: FontConstant.cairo,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/all-health-tips');
                },
                child: Text(
                  'عرض المزيد',
                  style: getBoldStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<HealthTipsCubit, HealthTipsState>(
            builder: (context, state) {
              if (state is LatestTipLoading) {
                return const DailyTipCard(heroTag: 'main_tip_loading'); // عرض التصميم الافتراضي أثناء التحميل
              } else if (state is LatestTipSuccess) {
                return DailyTipCard(
                  tip: state.tip,
                  heroTag: 'main_tip_${state.tip.id}',
                );
              } else if (state is LatestTipFailure) {
                return const DailyTipCard(heroTag: 'main_tip_error'); // عرض التصميم الافتراضي في حالة الخطأ
              }
              return const DailyTipCard(heroTag: 'main_tip_default'); // التصميم الافتراضي
            },
          ),
          
          const SizedBox(height: 24),
          
          // Articles section
          Text(
            'مقالات طبية',
            style: getBoldStyle(
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
