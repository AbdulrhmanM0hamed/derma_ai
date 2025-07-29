import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorLocationWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorLocationWidget({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> location =
        (doctorData["location"] as Map<String, dynamic>?) ?? {};

    if (location.isEmpty) {
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
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "الموقع",
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          _AddressCard(location: location),
          SizedBox(height: screenHeight * 0.02),
          const _MapPlaceholder(),
          SizedBox(height: screenHeight * 0.02),
          _ActionButtons(location: location),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }
}

class _AddressCard extends StatelessWidget {
  final Map<String, dynamic> location;

  const _AddressCard({required this.location});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (location["clinicName"] as String?) ?? "اسم العيادة",
            style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                color: AppColors.textPrimary,
                fontSize: 14),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            (location["address"] as String?) ?? "العنوان بالتفصيل",
            style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: AppColors.textSecondary,
                fontSize: 12),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            (location["district"] as String?) ?? "الحي",
            style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: AppColors.textSecondary,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.2,
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(
          color: AppColors.textSecondary.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  color: AppColors.textSecondary,
                  size: screenWidth * 0.1,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "خريطة الموقع",
                  style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      color: AppColors.textSecondary,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenWidth * 0.02,
            right: screenWidth * 0.02,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textSecondary.withValues(alpha:0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.directions_outlined,
                color: AppColors.primary,
                size: screenWidth * 0.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Map<String, dynamic> location;

  const _ActionButtons({required this.location});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.near_me_outlined,
                  color: Colors.amber.shade700,
                  size: screenWidth * 0.04,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "${(location["distance"] as String?) ?? "0"} كم",
                  style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    color: Colors.amber.shade800,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Handle directions navigation
            },
            icon: Icon(
              Icons.directions_outlined,
              color: Colors.white,
              size: screenWidth * 0.04,
            ),
            label: Text(
              "الاتجاهات",
              style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  color: Colors.white,
                  fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.019),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
