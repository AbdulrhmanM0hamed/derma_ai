import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorEducationWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorEducationWidget({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<dynamic> education = (doctorData["education"] as List?) ?? [];
    final List<dynamic> certifications =
        (doctorData["certifications"] as List?) ?? [];

    if (education.isEmpty && certifications.isEmpty) {
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
          Text(
            "التعليم والشهادات",
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Education Section
          if (education.isNotEmpty) ...[
            Text(
              "التعليم",
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: education.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: screenHeight * 0.015),
              itemBuilder: (context, index) {
                final edu = education[index] as Map<String, dynamic>;
                return _EducationListItem(edu: edu, index: index);
              },
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
          // Certifications Section
          if (certifications.isNotEmpty) ...[
            Text(
              "الشهادات",
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: certifications.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: screenHeight * 0.015),
              itemBuilder: (context, index) {
                final cert = certifications[index] as Map<String, dynamic>;
                return _CertificationListItem(cert: cert, index: index);
              },
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }
}

class _EducationListItem extends StatelessWidget {
  final Map<String, dynamic> edu;
  final int index;

  const _EducationListItem({required this.edu, required this.index});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.005),
          child: Icon(
            Icons.school_outlined,
            color: AppColors.primary,
            size: screenWidth * 0.05,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (edu["degree"] as String?) ?? "",
                style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textPrimary,
                    fontSize: 14),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                (edu["institution"] as String?) ?? "",
                style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textSecondary,
                    fontSize: 12),
              ),
              Text(
                (edu["year"] as String?) ?? "",
                style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textSecondary,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: -0.2);
  }
}

class _CertificationListItem extends StatelessWidget {
  final Map<String, dynamic> cert;
  final int index;

  const _CertificationListItem({required this.cert, required this.index});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.005),
          child: Icon(
            Icons.verified_user_outlined,
            color: Colors.amber.shade700,
            size: screenWidth * 0.05,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (cert["name"] as String?) ?? "",
                style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textPrimary,
                    fontSize: 14),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                (cert["issuer"] as String?) ?? "",
                style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textSecondary,
                    fontSize: 12),
              ),
              Text(
                (cert["year"] as String?) ?? "",
                style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textSecondary,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: -0.2);
  }
}
