import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/common/custom_button.dart';

class MapView extends StatelessWidget {
  final VoidCallback onToggleView;

  const MapView({
    super.key,
    required this.onToggleView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.cardBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              color: AppColors.primary,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "عرض الخريطة",
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontFamily: FontConstant.cairo,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "سيتم عرض مواقع الأطباء على الخريطة هنا",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            CustomButton(onPressed: onToggleView, text: "العودة للقائمة"),
          ],
        ),
      ),
    );
  }
}
