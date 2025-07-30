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

class _DailyTipCardState extends State<DailyTipCard>
    with TickerProviderStateMixin {
  bool _isBookmarked = false;
  bool _isExpanded = false;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;


    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            AppColors.primary.withValues(alpha: 0.02),
            AppColors.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 15,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Animated background decorations
          Positioned(
            top: -30,
            right: -30,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.1),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.1),
                          AppColors.primary.withValues(alpha: 0.03),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: AnimatedBuilder(
              animation: _shimmerController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _shimmerController.value * 2 * 3.14159,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.secondary.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Row(
                  children: [
                    Hero(
                      tag: 'daily_tip_icon',
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: AppColors.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: AppColors.primaryGradient,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'جديد',
                                  style: getBoldStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'نصيحة اليوم',
                                style: getBoldStyle(
                                  color: colorScheme.primary,
                                  fontSize: 20,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'لصحة بشرتك وجمالك الطبيعي',
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Content section with enhanced styling
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'حماية من أشعة الشمس',
                            style: getBoldStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'استخدم واقي الشمس يومياً حتى في الأيام الغائمة. الأشعة فوق البنفسجية تخترق الغيوم وتسبب أضراراً للبشرة.',
                        style: getRegularStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontFamily: FontConstant.cairo,
                          height: 1.6,
                        ),
                      ),
                      if (_isExpanded) ...[
                        const SizedBox(height: 12),
                        Text(
                          'اختر واقي شمس بعامل حماية SPF 30 أو أعلى، وأعد تطبيقه كل ساعتين للحصول على أفضل حماية.',
                          style: getRegularStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                            height: 1.5,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isExpanded ? 'عرض أقل' : 'اقرأ المزيد',
                              style: getSemiBoldStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const SizedBox(width: 4),
                            AnimatedRotation(
                              turns: _isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action buttons section
                Row(
                  children: [
                    // Time and category info
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.schedule_outlined,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'دقيقة واحدة',
                                  style: getSemiBoldStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'اليوم',
                              style: getRegularStyle(
                                color: AppColors.secondary,
                                fontSize: 11,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Action buttons
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isBookmarked = !_isBookmarked;
                              });
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: _isBookmarked
                                  ? AppColors.primary.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              shape: const CircleBorder(),
                            ),
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                key: ValueKey(_isBookmarked),
                                color: _isBookmarked ? AppColors.primary : AppColors.textSecondary,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Share functionality
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            shape: const CircleBorder(),
                          ),
                          icon: Icon(
                            Icons.share_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3).then()
     .shimmer(duration: 2000.ms, color: AppColors.primary.withValues(alpha: 0.1));
  }
}
