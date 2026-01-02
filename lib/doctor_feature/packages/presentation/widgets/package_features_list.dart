import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/package_model.dart';
import '../../data/models/package_type_config.dart';

// Package Features List Widget
class PackageFeaturesList extends StatelessWidget {
  final PackageModel package;
  final PackageTypeConfig config;
  final int maxFeatures;

  const PackageFeaturesList({
    super.key,
    required this.package,
    required this.config,
    this.maxFeatures = 4,
  });

  @override
  Widget build(BuildContext context) {
    if (package.features.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المميزات',
          style: getBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: FontSize.size16,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...package.features.take(maxFeatures).map((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color:
                        feature.included
                            ? config.primaryColor.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    feature.included
                        ? Icons.check_rounded
                        : Icons.close_rounded,
                    size: 16,
                    color: feature.included ? config.primaryColor : Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${feature.featureName}: ${feature.featureValue} ${feature.featureUnit}',
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        if (package.features.length > maxFeatures)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '+${package.features.length - maxFeatures} مميزات إضافية',
              style: getMediumStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size12,
                color: config.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
