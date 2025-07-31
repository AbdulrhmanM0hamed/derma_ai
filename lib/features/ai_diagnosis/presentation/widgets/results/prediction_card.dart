import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class PredictionCard extends StatelessWidget {
  final String condition;
  final String conditionArabic;
  final double confidence;
  final String severity;

  const PredictionCard({
    super.key,
    required this.condition,
    required this.conditionArabic,
    required this.confidence,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
     
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withValues(alpha:0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التشخيص الأعلى احتمالاً',
                style: Theme.of(context).textTheme.titleMedium,
                textDirection: TextDirection.rtl,
              ),
              Text(
                '${confidence.toStringAsFixed(1)}% ثقة',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conditionArabic,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      condition,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              _buildSeverityBadge(severity, context),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
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
        color: badgeColor.withValues(alpha:0.1),
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
    );
  }
}
