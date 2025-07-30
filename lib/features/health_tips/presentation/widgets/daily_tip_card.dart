import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class DailyTipCard extends StatefulWidget {
  const DailyTipCard({super.key});

  @override
  State<DailyTipCard> createState() => _DailyTipCardState();
}

class _DailyTipCardState extends State<DailyTipCard> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.quaternary.withValues(alpha:0.15),
            AppColors.quaternary.withValues(alpha:0.08),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.3, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.quaternary.withValues(alpha:0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha:0.8),
            blurRadius: 10,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.quaternary.withValues(alpha:0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.quaternary.withValues(alpha:0.08),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.quaternary,
                            AppColors.quaternary.withValues(alpha:0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.quaternary.withValues(alpha:0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.tips_and_updates_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'نصيحة اليوم',
                            style: getBoldStyle(
                              color: AppColors.quaternary,
                              fontSize: 20,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'نصيحة مفيدة لصحة بشرتك',
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBookmarked = !_isBookmarked;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isBookmarked 
                                  ? AppColors.quaternary.withValues(alpha:0.1)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: _isBookmarked ? AppColors.quaternary : AppColors.textSecondary,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Share functionality
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.quaternary.withValues(alpha:0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              color: AppColors.quaternary,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.quaternary.withValues(alpha:0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'استخدم واقي الشمس يومياً حتى في الأيام الغائمة. الأشعة فوق البنفسجية تخترق الغيوم وتسبب أضراراً للبشرة. اختر واقي شمس بعامل حماية SPF 30 أو أعلى.',
                    style: getRegularStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontFamily: FontConstant.cairo,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.quaternary.withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 16,
                            color: AppColors.quaternary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'قراءة دقيقة واحدة',
                            style: getSemiBoldStyle(
                              color: AppColors.quaternary,
                              fontSize: 12,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'اليوم',
                      style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2).then()
     .shimmer(duration: 1500.ms, color: AppColors.quaternary.withValues(alpha:0.1));
  }
}
