import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onAdjustFilters;

  const EmptyStateWidget({
    super.key,
    required this.onAdjustFilters,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              color: AppColors.textSecondary,
              size: screenWidth * 0.2,
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              "لا توجد نتائج",
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "لم نتمكن من العثور على أطباء يطابقون معايير البحث الحالية. جرب تعديل الفلاتر أو توسيع نطاق البحث.",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: onAdjustFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "تعديل الفلاتر",
                style: getSemiBoldStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
