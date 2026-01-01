import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/package_type_config.dart';

// Packages Tab Bar Widget
class PackagesTabBar extends StatelessWidget {
  final PackageType selectedType;
  final Function(PackageType) onTypeSelected;

  const PackagesTabBar({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children:
            PackageType.values.map((type) {
              final config = PackageTypeConfig.getConfig(type);
              final isSelected = selectedType == type;

              return Expanded(
                child: _TabItem(
                  config: config,
                  isSelected: isSelected,
                  onTap: () => onTypeSelected(type),
                ),
              );
            }).toList(),
      ),
    );
  }
}

// Tab Item Widget
class _TabItem extends StatelessWidget {
  final PackageTypeConfig config;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.config,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : null,

          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          config.tabLabel,
          style: getMediumStyle(
            fontFamily: FontConstant.cairo,
            fontSize: FontSize.size12,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
