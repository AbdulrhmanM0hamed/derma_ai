import 'package:flutter/material.dart';
import '../../../../core/utils/theme/app_colors.dart';

// Package Type Config
class PackageTypeConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final List<Color> gradientColors;
  final IconData icon;
  final String badgeText;
  final String tabLabel;

  const PackageTypeConfig({
    required this.primaryColor,
    required this.secondaryColor,
    required this.gradientColors,
    required this.icon,
    required this.badgeText,
    required this.tabLabel,
  });

  // Get config by package type
  static PackageTypeConfig getConfig(PackageType type) {
    switch (type) {
      case PackageType.premium:
        return const PackageTypeConfig(
          primaryColor: Color(0xFFFFD700),
          secondaryColor: Color(0xFFFFF8DC),
          gradientColors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          icon: Icons.workspace_premium_rounded,
          badgeText: 'بريميوم',
          tabLabel: 'بريميوم',
        );
      case PackageType.featured:
        return PackageTypeConfig(
          primaryColor: AppColors.primary,
          secondaryColor: AppColors.primary.withValues(alpha: 0.1),
          gradientColors: AppColors.medicalGradient,
          icon: Icons.star_rounded,
          badgeText: 'مميزة',
          tabLabel: 'مميزة',
        );
      case PackageType.cheapest:
        return PackageTypeConfig(
          primaryColor: AppColors.success,
          secondaryColor: AppColors.success.withValues(alpha: 0.1),
          gradientColors: const [AppColors.success, Color(0xFF20C997)],
          icon: Icons.local_offer_rounded,
          badgeText: 'اقتصادية',
          tabLabel: 'اقتصادية',
        );
      case PackageType.standard:
        return PackageTypeConfig(
          primaryColor: AppColors.textSecondary,
          secondaryColor: Colors.grey,
          gradientColors: const [Color(0xFF757575), Color(0xFF9E9E9E)],
          icon: Icons.card_giftcard_rounded,
          badgeText: 'قياسية',
          tabLabel: 'قياسية',
        );
      case PackageType.all:
        return PackageTypeConfig(
          primaryColor: AppColors.primary,
          secondaryColor: AppColors.primary.withValues(alpha: 0.1),
          gradientColors: AppColors.medicalGradient,
          icon: Icons.apps_rounded,
          badgeText: 'الكل',
          tabLabel: 'الكل',
        );
    }
  }
}

// Package Type Enum
enum PackageType { all, standard, featured, premium, cheapest }
