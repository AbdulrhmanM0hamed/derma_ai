import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/theme/app_colors.dart';

class RecommendationsSection extends StatelessWidget {
  final List<String> recommendations;
  const RecommendationsSection({super.key, required this.recommendations});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التوصيات',
            style: Theme.of(context).textTheme.titleMedium,
            textDirection: TextDirection.rtl,
          ),
          const Divider(height: 20),
          ...recommendations.map((rec) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.third,
                    size: 20,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Text(
                      rec,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
