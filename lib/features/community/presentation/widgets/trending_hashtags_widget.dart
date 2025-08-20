import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import '../data/community_dummy_data.dart';

class TrendingHashtagsWidget extends StatelessWidget {
  const TrendingHashtagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hashtags = CommunityDummyData.getTrendingHashtags();
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: AppColors.secondary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'الأكثر تداولاً',
                  style: getSemiBoldStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hashtags.length,
              itemBuilder: (context, index) {
                final hashtag = hashtags[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Handle hashtag tap
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getHashtagColor(index).withValues(alpha: 0.1),
                            _getHashtagColor(index).withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getHashtagColor(index).withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _getHashtagColor(index),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '#$hashtag',
                            style: getSemiBoldStyle(
                              fontSize: 12,
                              fontFamily: FontConstant.cairo,
                              color: _getHashtagColor(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate()
                    .fadeIn(delay: Duration(milliseconds: 50 * index))
                    .slideX(begin: 0.3);
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getHashtagColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.tertiary,
      AppColors.quaternary,
      Colors.orange,
      Colors.purple,
    ];
    return colors[index % colors.length];
  }
}
