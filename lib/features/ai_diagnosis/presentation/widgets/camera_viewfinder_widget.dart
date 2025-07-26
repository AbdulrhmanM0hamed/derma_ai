import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class CameraViewfinderWidget extends StatelessWidget {
  final CameraController? cameraController;
  final bool isFlashOn;
  final VoidCallback onFlashToggle;
  final bool isInitialized;

  const CameraViewfinderWidget({
    super.key,
    required this.cameraController,
    required this.isFlashOn,
    required this.onFlashToggle,
    required this.isInitialized,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Camera Preview
            if (isInitialized && cameraController != null)
              Positioned.fill(
                child: CameraPreview(cameraController!).animate().fadeIn(),
              )
            else
              Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'جاري تحضير الكاميرا...',
                        style: getRegularStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),

            // Overlay Guide
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Corner indicators
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                                left: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                                right: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                                left: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                                right: BorderSide(
                                  color: AppColors.primary,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Flash Toggle Button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: onFlashToggle,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: isFlashOn ? Colors.yellow : Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Lighting Indicator
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'إضاءة جيدة',
                      style: getRegularStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: FontConstant.cairo,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
