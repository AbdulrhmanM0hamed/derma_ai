import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.warning.withValues(alpha:0.5),
          width: 1,
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: AppColors.warning,
            size: 24,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Expanded(
            child: Text(
              'هذا التشخيص تم بواسطة الذكاء الاصطناعي وهو ليس بديلاً عن الاستشارة الطبية المتخصصة. للحصول على تشخيص دقيق، يرجى استشارة طبيب.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.warning,
                    height: 1.5,
                  ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}
