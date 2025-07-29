import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorWorkingHoursWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorWorkingHoursWidget({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> workingHours =
        (doctorData["workingHours"] as Map<String, dynamic>?) ?? {};

    if (workingHours.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: AppColors.primary,
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "ساعات العمل",
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workingHours.keys.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: screenHeight * 0.01),
            itemBuilder: (context, index) {
              final day = workingHours.keys.elementAt(index);
              final hours = workingHours[day] as Map<String, dynamic>;
              return _WorkingHoursListItem(day: day, hours: hours)
                  .animate()
                  .fadeIn(duration: 300.ms, delay: (100 * index).ms)
                  .slideY(begin: 0.2);
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }
}

class _WorkingHoursListItem extends StatelessWidget {
  final String day;
  final Map<String, dynamic> hours;

  const _WorkingHoursListItem({required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isAvailable = (hours["available" as String?]) ?? false;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColors.primary.withValues(alpha:0.05)
            : AppColors.textSecondary.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(
          color: isAvailable
              ? AppColors.primary.withValues(alpha:0.2)
              : AppColors.textSecondary.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Container(
                width: screenWidth * 0.02,
                height: screenWidth * 0.02,
                decoration: BoxDecoration(
                  color: isAvailable ? AppColors.primary : AppColors.textSecondary,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                isAvailable ? "${hours["start"]} - ${hours["end"]}" : "مغلق",
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  color: isAvailable
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
