import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/dummy_health_tips_data.dart';

class DiseaseInfoCard extends StatefulWidget {
  final DiseaseInfo disease;
  final int index;

  const DiseaseInfoCard({super.key, required this.disease, required this.index});

  @override
  State<DiseaseInfoCard> createState() => _DiseaseInfoCardState();
}

class _DiseaseInfoCardState extends State<DiseaseInfoCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.disease.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50,
                      height: 50,
                      color: colorScheme.secondary.withValues(alpha:.1),
                      child: Icon(
                        Icons.healing_outlined,
                        size: 24,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.disease.name,
                    style: getBoldStyle(
                      fontSize: 17,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.disease.description,
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Learn more
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'اعرف المزيد',
                      style: getSemiBoldStyle(
                        color: colorScheme.secondary,
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * widget.index)).slideY(begin: 0.2);
  }
}

