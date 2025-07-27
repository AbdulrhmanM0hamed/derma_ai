import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Animate(
                    effects: fadeInSlide(
                      duration: 300.ms,
                      beginX: -0.1,
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        'أ',
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Animate(
                          effects: fadeInSlide(
                            duration: 300.ms,
                            delay: 100.ms,
                            beginX: -0.1,
                          ),
                          child: Text(
                            'مرحباً بك',
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                        Animate(
                          effects: fadeInSlide(
                            duration: 300.ms,
                            delay: 200.ms,
                            beginX: -0.1,
                          ),
                          child: Text(
                            'أحمد محمد',
                            style: getBoldStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Animate(
                    effects: fadeInSlide(
                      duration: 300.ms,
                      delay: 300.ms,
                      beginX: 0.1,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Navigate to notifications
                      },
                      icon: Stack(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            color: AppColors.textPrimary,
                            size: 28,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
