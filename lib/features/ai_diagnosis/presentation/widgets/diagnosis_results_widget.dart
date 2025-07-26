import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/theme/app_colors.dart';

class DiagnosisResultsWidget extends StatelessWidget {
  final Map<String, dynamic> analysisResult;
  final VoidCallback onShareResult;
  final VoidCallback onSaveToHistory;

  const DiagnosisResultsWidget({
    Key? key,
    required this.analysisResult,
    required this.onShareResult,
    required this.onSaveToHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confidence = (analysisResult['confidence'] as double) * 100;
    final condition = analysisResult['condition'] as String;
    final conditionArabic = analysisResult['conditionArabic'] as String;
    final severity = analysisResult['severity'] as String;
    final recommendations = analysisResult['recommendations'] as List<String>;

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Results Header
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology_outlined,
                        color: AppColors.primary,
                        size: 32,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'نتائج التحليل',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                              ),
                              textDirection: TextDirection.rtl,
                            ).animate().fadeIn(),
                            Text(
                              'تم بواسطة الذكاء الاصطناعي',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppColors.textLight
                                    .withValues(alpha: 0.8),
                              ),
                              textDirection: TextDirection.rtl,
                            ).animate().fadeIn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // Confidence Score
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مستوى الثقة',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: TextDirection.rtl,
                      ).animate().fadeIn(),
                      Text(
                        '${confidence.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ).animate().fadeIn(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  LinearProgressIndicator(
                    value: confidence / 100,
                    backgroundColor: AppColors.border
                        .withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      confidence >= 80
                          ? AppColors.third
                          : confidence >= 60
                              ? Colors.orange
                              : AppColors.error,
                    ),
                  ).animate().fadeIn(),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // Condition Details
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الحالة المحتملة',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ).animate().fadeIn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    conditionArabic,
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ).animate().fadeIn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    condition,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ).animate().fadeIn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  _buildSeverityBadge(severity, context).animate().fadeIn(),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // Recommendations
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التوصيات',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ).animate().fadeIn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ...recommendations
                      .map((recommendation) => Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.005,
                                      left: MediaQuery.of(context).size.width * 0.02),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    recommendation,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                    textDirection: TextDirection.rtl,
                                  ).animate().fadeIn(),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // Disclaimer
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: AppColors.error,
                    size: 24,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تنبيه مهم',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                          textDirection: TextDirection.rtl,
                        ).animate().fadeIn(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          'هذه النتائج أولية وتم إنتاجها بواسطة الذكاء الاصطناعي. يُنصح بشدة باستشارة طبيب مختص للحصول على تشخيص دقيق وخطة علاج مناسبة.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textDirection: TextDirection.rtl,
                        ).animate().fadeIn(),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // Action Buttons
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onShareResult,
                          icon: Icon(
                            Icons.share_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          label: Text(
                            'مشاركة النتائج',
                            textDirection: TextDirection.rtl,
                          ),
                        ).animate().fadeIn(),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onSaveToHistory,
                          icon: Icon(
                            Icons.save_outlined,
                            color: AppColors.textLight,
                            size: 20,
                          ),
                          label: Text(
                            'حفظ في السجل',
                            textDirection: TextDirection.rtl,
                          ),
                        ).animate().fadeIn(),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/doctor-search-and-browse');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.third,
                        foregroundColor: AppColors.textLight,
                      ),
                      icon: Icon(
                        Icons.local_hospital_outlined,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                      label: Text(
                        'استشارة طبيب مختص',
                        textDirection: TextDirection.rtl,
                      ),
                    ).animate().fadeIn(),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildSeverityBadge(String severity, BuildContext context) {
    Color badgeColor;
    String severityArabic;

    switch (severity.toLowerCase()) {
      case 'mild':
        badgeColor = AppColors.third;
        severityArabic = 'خفيف';
        break;
      case 'moderate':
        badgeColor = Colors.orange;
        severityArabic = 'متوسط';
        break;
      case 'severe':
        badgeColor = AppColors.error;
        severityArabic = 'شديد';
        break;
      default:
        badgeColor = AppColors.textSecondary;
        severityArabic = 'غير محدد';
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: badgeColor,
          width: 1,
        ),
      ),
      child: Text(
        'الشدة: $severityArabic',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
        textDirection: TextDirection.rtl,
      ),
    ).animate().fadeIn();
  }
}
