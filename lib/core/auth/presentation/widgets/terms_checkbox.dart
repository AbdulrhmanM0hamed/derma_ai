import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/theme/app_colors.dart';

/// A theme-aware terms and conditions checkbox widget
class TermsCheckbox extends StatelessWidget {
  final bool value;
  final String agreeText;
  final String termsText;
  final String andText;
  final String privacyText;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.agreeText,
    required this.termsText,
    required this.andText,
    required this.privacyText,
    required this.onChanged,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onChanged(!value);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 2),
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
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Wrap(
            children: [
              Text(
                agreeText,
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onTermsTap,
                child: Text(
                  termsText,
                  style: getMediumStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ),
              Text(
                ' $andText ',
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: onPrivacyTap,
                child: Text(
                  privacyText,
                  style: getMediumStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
