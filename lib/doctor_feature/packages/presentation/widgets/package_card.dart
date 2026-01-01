import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/package_model.dart';
import 'package_price_section.dart';
import 'package_features_list.dart';
import 'package_action_button.dart';

// Package Card Widget
class PackageCard extends StatelessWidget {
  final PackageModel package;
  final VoidCallback onTap;

  const PackageCard({super.key, required this.package, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final config = package.typeConfig;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: config.primaryColor.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: config.primaryColor.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      config.primaryColor.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        package.nameAr,
                        style: getBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: FontSize.size24,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: config.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          config.badgeText,
                          style: getBoldStyle(
                            fontFamily: FontConstant.cairo,
                            fontSize: FontSize.size12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Secondary name
                  Text(
                    package.secondaryNameAr,
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size14,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Price section
                  PackagePriceSection(package: package, config: config),

                  const SizedBox(height: 20),

                  // Features
                  PackageFeaturesList(package: package, config: config),

                  const SizedBox(height: 20),

                  // Action button
                  PackageActionButton(config: config, onTap: onTap),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
