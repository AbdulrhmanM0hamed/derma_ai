import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class CaptureControlsWidget extends StatelessWidget {
  final VoidCallback onCapture;
  final VoidCallback onGallery;
  final VoidCallback onFlashToggle;
  final bool isFlashOn;
  final bool isProcessing;

  const CaptureControlsWidget({
    super.key,
    required this.onCapture,
    required this.onGallery,
    required this.onFlashToggle,
    required this.isFlashOn,
    this.isProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Gallery Button
          _buildControlButton(
            context: context,
            onTap: onGallery,
            icon: Icons.photo_library_outlined,
            label: 'المعرض',
            isSecondary: true,
          ),

          // Capture Button
          GestureDetector(
            onTap:
                isProcessing
                    ? null
                    : () {
                      HapticFeedback.mediumImpact();
                      onCapture();
                    },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                color:
                    isProcessing ? AppColors.textSecondary : AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cardBackground, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child:
                  isProcessing
                      ? Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.cardBackground,
                          ),
                        ),
                      )
                      : Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.textLight,
                        size: 32,
                      ),
            ),
          ).animate().scale(duration: 500.ms, curve: Curves.easeInOut),

          // Flash Toggle Button
          _buildControlButton(
            context: context,
            onTap: onFlashToggle,
            icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
            label: isFlashOn ? 'إيقاف الفلاش' : 'تشغيل الفلاش',
            isSecondary: true,
            iconColor: isFlashOn ? Colors.yellow : null,
          ).animate().fadeIn(duration: 500.ms),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required BuildContext context,
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    bool isSecondary = false,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
   
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.015,
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.textSecondary,
              size: 24,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            Text(
              label,
              style: getRegularStyle(
                color:
                    isSecondary ? AppColors.textSecondary : AppColors.textLight,
                fontSize: MediaQuery.of(context).size.width * 0.025,
                fontFamily: FontConstant.cairo,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    ));
  }
}
