import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/package_model.dart';
import '../../data/models/package_type_config.dart';

// Package Price Section Widget
class PackagePriceSection extends StatelessWidget {
  final PackageModel package;
  final PackageTypeConfig config;

  const PackagePriceSection({
    super.key,
    required this.package,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: config.secondaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'السعر',
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: FontSize.size12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${package.price.toInt()}',
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 32,
                      color: config.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      package.currencyCode,
                      style: getMediumStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: FontSize.size16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Duration
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: config.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: config.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '${package.durationDays} يوم',
                  style: getMediumStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size14,
                    color: config.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
