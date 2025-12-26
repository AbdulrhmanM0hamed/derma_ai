import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';

class CommunityStatsWidget extends StatelessWidget {
  const CommunityStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.tertiary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.analytics_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'إحصائيات المجتمع',
                style: getBoldStyle(
                  fontSize: 18,
                  fontFamily: FontConstant.cairo,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.group_outlined,
                  title: 'الأعضاء',
                  value: '25.4K',
                  subtitle: '+12% هذا الشهر',
                  color: AppColors.primary,
                  index: 0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.article_outlined,
                  title: 'المنشورات',
                  value: '1.2K',
                  subtitle: '+8% هذا الأسبوع',
                  color: AppColors.secondary,
                  index: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.local_hospital_outlined,
                  title: 'الأطباء',
                  value: '156',
                  subtitle: 'متخصص معتمد',
                  color: AppColors.tertiary,
                  index: 2,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'التعليقات',
                  value: '8.9K',
                  subtitle: 'اليوم',
                  color: AppColors.quaternary,
                  index: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required int index,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha:  0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              const Spacer(),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: getBoldStyle(
              fontSize: 20,
              fontFamily: FontConstant.cairo,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: getSemiBoldStyle(
              fontSize: 12,
              fontFamily: FontConstant.cairo,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: getRegularStyle(
              fontSize: 10,
              fontFamily: FontConstant.cairo,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    ).animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index))
        .slideY(begin: 0.3)
        .scale(begin: const Offset(0.9, 0.9));
  }
}
