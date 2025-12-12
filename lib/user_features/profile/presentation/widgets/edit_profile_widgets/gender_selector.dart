import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';

/// A theme-aware gender selector widget
class GenderSelector extends StatelessWidget {
  final String label;
  final String? selectedGender;
  final String maleLabel;
  final String femaleLabel;
  final ValueChanged<String> onGenderSelected;

  const GenderSelector({
    super.key,
    required this.label,
    required this.selectedGender,
    required this.maleLabel,
    required this.femaleLabel,
    required this.onGenderSelected,
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
              child: _GenderOption(
                value: 'male',
                label: maleLabel,
                icon: Icons.male_rounded,
                color: Colors.blue,
                isSelected: selectedGender == 'male',
                onTap: () => onGenderSelected('male'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GenderOption(
                value: 'female',
                label: femaleLabel,
                icon: Icons.female_rounded,
                color: Colors.pink,
                isSelected: selectedGender == 'female',
                onTap: () => onGenderSelected('female'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.value,
    required this.label,
    required this.icon,
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
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.2)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? color : (isDark ? Colors.grey[500] : Colors.grey[600]),
                size: 32,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: getSemiBoldStyle(
                fontSize: 13,
                fontFamily: FontConstant.cairo,
                color: isSelected ? color : (isDark ? Colors.grey[400] : Colors.grey[700]),
              ),
              textAlign: TextAlign.center,
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
