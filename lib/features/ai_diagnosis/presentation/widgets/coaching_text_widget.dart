import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class CoachingTextWidget extends StatelessWidget {
  final String mainText;
  final String? subText;
  final bool isProcessing;

  const CoachingTextWidget({
    super.key,
    required this.mainText,
    this.subText,
    this.isProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Animate(
      effects: const [FadeEffect(duration: Duration(milliseconds: 400)), SlideEffect()],
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: isSmallScreen ? 12 : 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mainText,
              textAlign: TextAlign.center,
              style: getSemiBoldStyle(
                color: AppColors.textPrimary,
                fontSize: isSmallScreen ? 16 : 18,
                fontFamily: FontConstant.cairo,
              ),
            ),
            if (subText != null) ...[
              const SizedBox(height: 8),
              Text(
                subText!,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontSize: isSmallScreen ? 13 : 14,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ],
            if (isProcessing) ...[
              SizedBox(height: isSmallScreen ? 16 : 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Processing...',
                    style: getRegularStyle(
                      color: AppColors.textSecondary,
                      fontSize: isSmallScreen ? 13 : 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
