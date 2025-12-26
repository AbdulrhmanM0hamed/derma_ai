import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class OtherPredictionsSection extends StatelessWidget {
  final List<dynamic> otherPredictions;

  const OtherPredictionsSection({super.key, required this.otherPredictions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          'تشخيصات أخرى محتملة',
          style: Theme.of(context).textTheme.titleMedium,
          textDirection: TextDirection.rtl,
        ),
        children: otherPredictions.map((prediction) {
          final confidence = (prediction['confidence'] as double) * 100;
          return ListTile(
            title: Text(
              prediction['conditionArabic'] as String,
              textDirection: TextDirection.rtl,
            ),
            subtitle: Text(
              prediction['condition'] as String,
              textDirection: TextDirection.rtl,
            ),
            trailing: Text(
              '${confidence.toStringAsFixed(1)}%',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 500.ms);
  }
}
