import 'package:derma_ai/user_features/health_tips/presentation/pages/all_medical_articles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/dummy_health_tips_data.dart';
import '../bloc/health_tips_cubit.dart';
import '../bloc/health_tips_state.dart';
import 'article_card.dart';
import 'article_shimmer_card.dart';
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
    // تحميل المقالات الطبية
    context.read<HealthTipsCubit>().getMedicalArticles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
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
                l10n.dailyTip,
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
                  l10n.viewMore,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.medicalArticles,
                style: getBoldStyle(
                  fontSize: 20,
                  fontFamily: FontConstant.cairo,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AllMedicalArticlesPage.routeName);
                },
                child: Text(
                  l10n.viewMore,
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
          // Medical Articles BlocBuilder
          BlocBuilder<HealthTipsCubit, HealthTipsState>(
            builder: (context, state) {
              if (state is MedicalArticlesLoading) {
                return const ArticleShimmerList(itemCount: 3);
              } else if (state is MedicalArticlesSuccess) {
                // عرض أول 3 مقالات فقط في الصفحة الرئيسية
                final articlesToShow = state.articles.take(3).toList();
                return Column(
                  children: articlesToShow.asMap().entries.map((entry) {
                    final index = entry.key;
                    final article = entry.value;
                    return ArticleCard(article: article, index: index);
                  }).toList(),
                );
              } else if (state is MedicalArticlesFailure) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.errorLoadingTips,
                        style: getBoldStyle(
                          color: Colors.red.shade700,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.message,
                        style: getRegularStyle(
                          color: Colors.red.shade600,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          
          const SizedBox(height: 24),
          
          // Disease info section
          Text(
            l10n.diseaseInformation,
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
