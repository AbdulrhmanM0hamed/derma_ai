import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/theme/app_colors.dart';

/// A theme-aware remember me checkbox widget
class RememberMeCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  const RememberMeCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onChanged(!value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: value
                  ? AppColors.primary
                  : (isDark ? Colors.grey[800] : Colors.grey[100]),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: value
                    ? AppColors.primary
                    : (isDark ? Colors.grey[600]! : Colors.grey[300]!),
                width: 1.5,
              ),
              boxShadow: value
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: value
                ? const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: getRegularStyle(
              color: isDark ? Colors.grey[300] : AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ],
      ),
    );
  }
}
