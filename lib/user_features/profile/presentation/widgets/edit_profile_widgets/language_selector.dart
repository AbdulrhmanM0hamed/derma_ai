import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';

/// A theme-aware language selector widget
class LanguageSelector extends StatelessWidget {
  final String label;
  final String? selectedLanguage;
  final String arabicLabel;
  final String englishLabel;
  final ValueChanged<String> onLanguageSelected;

  const LanguageSelector({
    super.key,
    required this.label,
    required this.selectedLanguage,
    required this.arabicLabel,
    required this.englishLabel,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getSemiBoldStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _LanguageOption(
                value: 'ar',
                label: arabicLabel,
                flag: '🇸🇦',
                color: Colors.green,
                isSelected: selectedLanguage == 'ar',
                onTap: () => onLanguageSelected('ar'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _LanguageOption(
                value: 'en',
                label: englishLabel,
                flag: '🇬🇧',
                color: Colors.indigo,
                isSelected: selectedLanguage == 'en',
                onTap: () => onLanguageSelected('en'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String value;
  final String label;
  final String flag;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.value,
    required this.label,
    required this.flag,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    color.withValues(alpha: isDark ? 0.3 : 0.15),
                    color.withValues(alpha: isDark ? 0.15 : 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected
              ? null
              : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                label,
                style: getBoldStyle(
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                  color: isSelected ? color : (isDark ? Colors.grey[400] : Colors.grey[700]),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scale(
          duration: 200.ms,
          begin: const Offset(1, 1),
          end: const Offset(1.03, 1.03),
        );
  }
}
