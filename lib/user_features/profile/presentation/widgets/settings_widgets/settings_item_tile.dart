import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';

/// A reusable settings item tile with theme-aware styling
class SettingsItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool showArrow;
  final Color? titleColor;
  final Color? iconColor;
  final Widget? trailing;

  const SettingsItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showArrow = false,
    this.titleColor,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = iconColor ?? (isDark ? Colors.grey[400] : Colors.grey[600]);
    final defaultTitleColor = titleColor;
    final subtitleColor = isDark ? Colors.grey[500] : Colors.grey[600];
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey[200]!;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (iconColor ?? defaultIconColor)!.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? defaultIconColor,
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
                          color: defaultTitleColor,
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
                // Trailing Widget or Arrow
                if (trailing != null)
                  trailing!
                else if (showArrow)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
