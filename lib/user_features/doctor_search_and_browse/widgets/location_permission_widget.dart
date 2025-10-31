import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';


class LocationPermissionWidget extends StatelessWidget {
  final VoidCallback onAllowLocation;
  final VoidCallback onSkip;

  const LocationPermissionWidget({
    super.key,
    required this.onAllowLocation,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            color: AppColors.primary,
            size: screenWidth * 0.2,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "السماح بالوصول للموقع",
            style: getSemiBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "للعثور على أقرب الأطباء إليك وتحديد المسافات بدقة، نحتاج للوصول إلى موقعك الحالي",
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onSkip,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.border),
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "تخطي",
                    style: getMediumStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAllowLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "السماح",
                    style: getMediumStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
