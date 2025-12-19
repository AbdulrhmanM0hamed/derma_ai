import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/skin_disease_model.dart';

class SkinDiseaseCard extends StatelessWidget {
  final SkinDiseaseModel disease;
  final int index;

  const SkinDiseaseCard({
    super.key,
    required this.disease,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.healing_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        disease.title,
                        style: getBoldStyle(
                          fontSize: 17,
                          fontFamily: FontConstant.cairo,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'حالة جلدية',
                          style: getRegularStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              disease.description,
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  'معلومات طبية',
                  style: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Show full description in dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          disease.title,
                          style: getBoldStyle(
                            fontSize: 18,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Text(
                            disease.description,
                            style: getRegularStyle(
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                              height: 1.6,
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'إغلاق',
                              style: getSemiBoldStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'اعرف المزيد',
                        style: getSemiBoldStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index))
        .slideY(begin: 0.2);
  }
}
