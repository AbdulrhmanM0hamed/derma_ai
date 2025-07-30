import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/dummy_health_tips_data.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  final int index;

  const ArticleCard({super.key, required this.article, required this.index});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard>
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
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppColors.secondary.withValues(alpha: 0.05),
                AppColors.third.withValues(alpha: 0.05),
                AppColors.secondary.withValues(alpha: 0.09),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.7, 1.0],
            ),
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
                              AppColors.secondary.withValues(alpha: 0.1),
                              AppColors.secondary.withValues(alpha: 0.03),
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
                              AppColors.primary.withValues(alpha: 0.08),
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
                          tag: 'article_icon_${widget.index}',
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppColors.secondaryGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.secondary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.article_outlined,
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
                                        colors: AppColors.secondaryGradient,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'مقال طبي',
                                      style: getBoldStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.article.title,
                                      style: getBoldStyle(
                                        color: colorScheme.primary,
                                        fontSize: 18,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.article.source,
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
                          color: AppColors.secondary.withValues(alpha: 0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.05),
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
                                Icons.menu_book_outlined,
                                color: AppColors.secondary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'محتوى المقال',
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
                            'مقال طبي شامل يحتوي على معلومات مفيدة وموثقة من مصادر طبية معتمدة لمساعدتك في فهم الموضوع بشكل أفضل.',
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
                              'يتضمن المقال أحدث الأبحاث والدراسات العلمية في هذا المجال، مع توضيحات مبسطة وسهلة الفهم.',
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
                                  color: AppColors.secondary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.schedule_outlined,
                                      size: 16,
                                      color: AppColors.secondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '5 دقائق',
                                      style: getSemiBoldStyle(
                                        color: AppColors.secondary,
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
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'جديد',
                                  style: getRegularStyle(
                                    color: AppColors.primary,
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
                                  backgroundColor:
                                      _isBookmarked
                                          ? AppColors.secondary.withValues(
                                            alpha: 0.1,
                                          )
                                          : Colors.transparent,
                                  shape: const CircleBorder(),
                                ),
                                icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(
                                    _isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    key: ValueKey(_isBookmarked),
                                    color:
                                        _isBookmarked
                                            ? AppColors.secondary
                                            : AppColors.textSecondary,
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
                                backgroundColor: AppColors.secondary.withValues(
                                  alpha: 0.1,
                                ),
                                shape: const CircleBorder(),
                              ),
                              icon: Icon(
                                Icons.share_outlined,
                                color: AppColors.secondary,
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
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.3)
        .then()
        .shimmer(
          duration: 2000.ms,
          color: AppColors.secondary.withValues(alpha: 0.1),
        );
  }
}
