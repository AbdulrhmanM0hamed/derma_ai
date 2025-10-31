import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/theme/app_colors.dart';

class ResultActions extends StatelessWidget {
  final VoidCallback onShareResult;
  final VoidCallback onSaveToHistory;
  final VoidCallback onFindDoctor;

  const ResultActions({
    super.key,
    required this.onShareResult,
    required this.onSaveToHistory,
    required this.onFindDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onShareResult,
                  icon: Icon(
                    Icons.share_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  label: const Text(
                    'مشاركة النتائج',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSaveToHistory,
                  icon: const Icon(
                    Icons.save_outlined,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                  label: const Text(
                    'حفظ في السجل',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton.icon(
          //     onPressed: onFindDoctor,
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColors.third,
          //       foregroundColor: AppColors.textLight,
          //     ),
          //     icon: const Icon(
          //       Icons.local_hospital_outlined,
          //       color: AppColors.textLight,
          //       size: 20,
          //     ),
          //     label: const Text(
          //       'استشارة طبيب مختص',
          //       textDirection: TextDirection.rtl,
          //     ),
          //   ),
          // ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms);
  }
}
