import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../core/utils/theme/app_colors.dart';

/// A reusable settings dropdown tile with theme-aware styling
class SettingsDropdownTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color? iconColor;

  const SettingsDropdownTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.items,
    required this.onChanged,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = iconColor ?? (isDark ? Colors.grey[400] : Colors.grey[600]);
    final subtitleColor = isDark ? Colors.grey[500] : Colors.grey[600];
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey[200]!;
    final dropdownBgColor = isDark ? Colors.grey[800] : Colors.white;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: defaultIconColor!.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: defaultIconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 12,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            // Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isDense: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  dropdownColor: dropdownBgColor,
                  borderRadius: BorderRadius.circular(12),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: getMediumStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    HapticFeedback.lightImpact();
                    onChanged(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
