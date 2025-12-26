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
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF667EEA).withValues(alpha: 0.4),
          //     blurRadius: 20,
          //     spreadRadius: 2,
          //     offset: const Offset(0, 10),
          //   ),
          //   BoxShadow(
          //     color: const Color(0xFF764BA2).withValues(alpha: 0.2),
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
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
                  // Left side - Text content
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 12,
                        //     vertical: 6,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withValues(alpha: 0.2),
                        //     borderRadius: BorderRadius.circular(20),
                        //     border: Border.all(
                        //       color: Colors.white.withValues(alpha: 0.3),
                        //       width: 1,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Icon(
                        //         Icons.verified,
                        //         color: Colors.white,
                        //         size: 14,
                        //       ),
                        //       const SizedBox(width: 6),
                        //       Text(
                        //         'أطباء معتمدون',
                        //         style: getSemiBoldStyle(
                        //           color: Colors.white,
                        //           fontSize: 11,
                        //           fontFamily: FontConstant.cairo,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 16),
                        // Title
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
                        // const SizedBox(height: 20),
                        // Features row
                        // Row(
                        //   children: [
                        //     _buildFeatureChip(
                        //       icon: Icons.star_rounded,
                        //       label: 'تقييمات عالية',
                        //     ),
                        //     const SizedBox(width: 8),
                        //     _buildFeatureChip(
                        //       icon: Icons.schedule,
                        //       label: 'حجز سريع',
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 20),
                        // CTA Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Navigate to doctors list
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withValues(alpha: 0.15),
                                //     blurRadius: 10,
                                //     offset: const Offset(0, 4),
                                //   ),
                                // ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'تصفح الآن',
                                    style: getBoldStyle(
                                      color: AppColors.white,
                                      fontSize: 15,
                                      fontFamily: FontConstant.cairo,
                                    ),
                                  ),
                                  // const SizedBox(width: 8),
                                  // Container(
                                  //   padding: const EdgeInsets.all(4),
                                  //   decoration: BoxDecoration(
                                  //     color: AppColors.white.withOpacity(0.2),
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: Icon(
                                  //     Icons.arrow_forward_rounded,
                                  //     color: AppColors.white,
                                  //     size: 16,
                                  //   ),
                                  // ),
                                ],
                              ),
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
                          width: 120,
                          height: 120,
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

  // Widget _buildFeatureChip({required IconData icon, required String label}) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withValues(alpha: 0.15),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(icon, color: Colors.amber[300], size: 14),
  //         const SizedBox(width: 4),
  //         Text(
  //           label,
  //           style: getRegularStyle(
  //             color: Colors.white,
  //             fontSize: 11,
  //             fontFamily: FontConstant.cairo,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
