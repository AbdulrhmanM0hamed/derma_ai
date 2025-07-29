import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/theme/app_colors.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/constant/font_manger.dart';

class DoctorAboutSectionWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  const DoctorAboutSectionWidget({super.key, required this.doctorData});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                "نبذة عن الطبيب",
                style: getBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontFamily: FontConstant.cairo,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 100.ms)
              .slideY(begin: 0.2),
          SizedBox(height: screenHeight * 0.02),
          Text(
                (doctorData["arabicBio"] as String?) ??
                    "معلومات الطبيب غير متوفرة حالياً",
                style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
                textAlign: TextAlign.justify,
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.2),
          SizedBox(height: screenHeight * 0.025),
          Text(
                "الخلفية الطبية",
                style: getSemiBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontFamily: FontConstant.cairo,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 300.ms)
              .slideY(begin: 0.2),
          SizedBox(height: screenHeight * 0.015),
          Text(
                (doctorData["medicalBackground"] as String?) ??
                    "الخلفية الطبية غير متوفرة حالياً",
                style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
                textAlign: TextAlign.justify,
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .slideY(begin: 0.2),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 50.ms).scaleXY(begin: 0.95);
  }
}
