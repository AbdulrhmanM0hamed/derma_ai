import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class DiagnosisHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> historyData;
  final Function(Map<String, dynamic>) onCompareResults;

  const DiagnosisHistoryWidget({
    Key? key,
    required this.historyData,
    required this.onCompareResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: AppColors.primary,
                size: 24,
              ).animate().fadeIn(),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Text(
                'سجل التشخيصات السابقة',
                style: getBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontFamily: FontConstant.cairo,
                ),
                textDirection: TextDirection.rtl,
              ).animate().fadeIn(),
            ],
          ),
        ),

        // History List
        Expanded(
          child: historyData.isEmpty
              ? _buildEmptyState(context)
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                  itemCount: historyData.length,
                  separatorBuilder: (context, index) => SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  itemBuilder: (context, index) {
                    final diagnosis = historyData[index];
                    return _buildHistoryCard(context, diagnosis, index);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              color: AppColors.textSecondary,
              size: 64,
            ).animate().fadeIn(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              'لا توجد تشخيصات سابقة',
              style: getSemiBoldStyle(
                color: AppColors.textSecondary,
                fontSize: 18,
                fontFamily: FontConstant.cairo,
              ),
              textDirection: TextDirection.rtl,
            ).animate().fadeIn(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              'ستظهر هنا جميع التشخيصات التي قمت بها',
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ).animate().fadeIn(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> diagnosis, int index) {
    final condition = diagnosis['condition'] as String;
    final date = diagnosis['date'] as DateTime;
    final confidence = (diagnosis['confidence'] as num).toDouble();
    final severity = diagnosis['severity'] as String;
    final imagePath = diagnosis['imagePath'] as String?;

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              // Image Thumbnail
              if (imagePath != null)
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imagePath,
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate().fadeIn()
              else
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.border.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                ).animate().fadeIn(),

              SizedBox(width: MediaQuery.of(context).size.width * 0.03),

              // Diagnosis Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      condition,
                      style: getSemiBoldStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontFamily: FontConstant.cairo,
                      ),
                      textDirection: TextDirection.rtl,
                    ).animate().fadeIn(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                      ),
                      textDirection: TextDirection.rtl,
                    ).animate().fadeIn(),
                  ],
                ),
              ),

              // Confidence Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.005),
                decoration: BoxDecoration(
                  color: confidence >= 80
                      ? AppColors.third.withValues(alpha: 0.1)
                      : confidence >= 60
                          ? Colors.orange.withValues(alpha: 0.1)
                          : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${confidence.toStringAsFixed(0)}%',
                  style: getSemiBoldStyle(
                    color: confidence >= 80
                        ? AppColors.third
                        : confidence >= 60
                            ? Colors.orange
                            : AppColors.error,
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                  ),
                ).animate().fadeIn(),
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          // Severity and Actions
          Row(
            children: [
              _buildSeverityChip(context, severity),
              Spacer(),
              TextButton.icon(
                onPressed: () => onCompareResults(diagnosis),
                icon: Icon(
                  Icons.compare_arrows,
                  color: AppColors.primary,
                  size: 16,
                ).animate().fadeIn(),
                label: Text(
                  'مقارنة',
                  style: getRegularStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                  ),
                  textDirection: TextDirection.rtl,
                ).animate().fadeIn(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.005),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityChip(BuildContext context, String severity) {
    Color chipColor;
    String severityArabic;

    switch (severity.toLowerCase()) {
      case 'mild':
        chipColor = AppColors.third;
        severityArabic = 'خفيف';
        break;
      case 'moderate':
        chipColor = AppColors.warning;
        severityArabic = 'متوسط';
        break;
      case 'severe':
        chipColor = AppColors.error;
        severityArabic = 'شديد';
        break;
      default:
        chipColor = AppColors.textSecondary;
        severityArabic = 'غير محدد';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.005),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: chipColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        severityArabic,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: chipColor,
          fontWeight: FontWeight.w500,
        ),
        textDirection: TextDirection.rtl,
      ).animate().fadeIn(),
    );
  }
}
