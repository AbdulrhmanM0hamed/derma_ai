import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';

class CommunityAppBar extends StatelessWidget {
  const CommunityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.8),
                AppColors.secondary.withValues(alpha: 0.6),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.groups_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ).animate().scale(delay: 200.ms, duration: 600.ms),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مجتمع ديرما',
                              style: getBoldStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: FontConstant.cairo,
                              ),
                            ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.3),
                            const SizedBox(height: 4),
                            Text(
                              'تواصل مع أطباء الجلدية وشارك تجربتك',
                              style: getRegularStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.3),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ).animate().scale(delay: 500.ms),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'ابحث في المجتمع...',
                          style: getRegularStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
