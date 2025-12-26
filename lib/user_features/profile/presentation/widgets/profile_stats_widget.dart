import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileStatsWidget extends StatelessWidget {
  const ProfileStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('التشخيصات', '12'),
          _buildStatItem('المواعيد', '5'),
          _buildStatItem('المفضلة', '8'),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 300.ms);
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontFamily: FontConstant.cairo,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
        ),
      ],
    );
  }
}
