import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';

class BrowseCosmeticDoctorsSection extends StatelessWidget {
  const BrowseCosmeticDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: fadeInScaleUp(duration: 500.ms, delay: 300.ms, begin: 0.95),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.8),
              // AppColors.primary.withValues(alpha: 0.6),
              // AppColors.primary.withValues(alpha: 0.4),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            // Sparkle decorations
            Positioned(
              top: 20,
              left: 30,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white.withValues(alpha: 0.3),
                size: 16,
              ),
            ),
            Positioned(
              bottom: 40,
              right: 50,
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white.withValues(alpha: 0.25),
                size: 12,
              ),
            ),
            // Main content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
    
                        Text(
                          'تصفح دكاترة التجميل',
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Subtitle
                        Text(
                          'اكتشف أفضل أطباء الجلدية والتجميل في منطقتك',
                          style: getRegularStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      
                        const SizedBox(height: 20),

                        // CTA Button
                        MaterialButton(
                          onPressed: () {},

                          shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 45,
                          minWidth: 120,
                          color: AppColors.cardBackground,
                          child: Text(
                            'تصفح الآن',
                            style: getBoldStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right side - Image/Illustration
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.15),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: SvgPicture.asset(
                              'assets/images/header_profile.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Stats
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.people_alt_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '+500 طبيب',
                                style: getSemiBoldStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
