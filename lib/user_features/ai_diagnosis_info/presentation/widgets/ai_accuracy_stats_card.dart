import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AiAccuracyStatsCard extends StatefulWidget {
  const AiAccuracyStatsCard({super.key});

  @override
  State<AiAccuracyStatsCard> createState() => _AiAccuracyStatsCardState();
}

class _AiAccuracyStatsCardState extends State<AiAccuracyStatsCard>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // Start progress animation after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'title': 'دقة التشخيص',
        'value': 95,
        'suffix': '%',
        'color': AppColors.primary,
        'icon': Icons.precision_manufacturing_outlined,
      },
      {
        'title': 'سرعة المعالجة',
        'value': 25,
        'suffix': 'ث',
        'color': AppColors.secondary,
        'icon': Icons.speed_outlined,
      },
      {
        'title': 'الحالات المشخصة',
        'value': 50000,
        'suffix': '+',
        'color': AppColors.tertiary,
        'icon': Icons.analytics_outlined,
      },
      {
        'title': 'رضا المستخدمين',
        'value': 98,
        'suffix': '%',
        'color': AppColors.quaternary,
        'icon': Icons.sentiment_very_satisfied_outlined,
      },
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.1),
                        child: Icon(
                          Icons.trending_up_outlined,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'إحصائيات الأداء',
                  style: getBoldStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Stats grid
            GridView.builder(
              padding:  EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];
                
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (stat['color'] as Color).withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (stat['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          stat['icon'] as IconData,
                          color: stat['color'] as Color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Animated value
                      AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          final animatedValue = (stat['value'] as int) * _progressController.value;
                          return Text(
                            '${animatedValue.toInt()}${stat['suffix']}',
                            style: getBoldStyle(
                              color: stat['color'] as Color,
                              fontSize: 20,
                              fontFamily: FontConstant.cairo,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      
                      // Title
                      Text(
                        stat['title'] as String,
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ).animate().fadeIn(
                  duration: 600.ms,
                  delay: Duration(milliseconds: 200 * index),
                ).scale(begin: const Offset(0.5, 0.5));
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.1);
  }
}
