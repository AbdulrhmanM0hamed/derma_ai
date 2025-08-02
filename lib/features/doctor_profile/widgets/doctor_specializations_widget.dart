import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';
import '../../../core/widgets/scroll_animated_widget.dart';

class DoctorSpecializationsWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorSpecializationsWidget({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<dynamic> specializations =
        (doctorData["specializations"] as List<dynamic>?) ?? [];

    if (specializations.isEmpty) {
      return const SizedBox.shrink();
    }

    final cardWidget = Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "التخصصات",
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
        
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: specializations.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: screenHeight * 0.01),
              itemBuilder: (context, index) {
                final specialization =
                    specializations[index] as Map<String, dynamic>;
                return _SpecializationListItem(specialization: specialization)
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (100 * index).ms)
                    .slideY(begin: 0.2);
              },
            ),
          ],
        ),
      ),
    );
    
    return ScrollAnimatedWidget(
      duration: const Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 100),
      slideOffset: 0.25,
      child: cardWidget,
    );
  }
}

class _SpecializationListItem extends StatelessWidget {
  final Map<String, dynamic> specialization;

  const _SpecializationListItem({required this.specialization});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(
          color: AppColors.primary.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Icon(
              Icons.medical_services_outlined,
              color: AppColors.primary,
              size: screenWidth * 0.06,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (specialization["arabicName"] as String?) ?? "",
                  style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (specialization["description"] as String?) ?? "",
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
