import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/animations/app_animations.dart';


class TimeSlotPicker extends StatelessWidget {
  final String? selectedTimeSlot;
  final Function(String) onTimeSlotSelected;

  const TimeSlotPicker({
    super.key,
    required this.selectedTimeSlot,
    required this.onTimeSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy time slots for demonstration
    // In a real app, these would be fetched from a repository based on doctor availability
    final morningSlots = [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
    ];

    final afternoonSlots = [
      '01:00 PM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
    ];

    final eveningSlots = [
      '05:00 PM',
      '06:00 PM',
      '07:00 PM',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimeSection('Morning', morningSlots),
        const SizedBox(height: 16),
        _buildTimeSection('Afternoon', afternoonSlots),
        const SizedBox(height: 16),
        _buildTimeSection('Evening', eveningSlots),
      ],
    );
  }

  Widget _buildTimeSection(String title, List<String> timeSlots) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getMediumStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo),

        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timeSlots.map((timeSlot) {
            final isSelected = timeSlot == selectedTimeSlot;
            final isAvailable = ![
              '09:00 AM',
              '02:00 PM',
              '06:00 PM',
            ].contains(timeSlot); // Simulate some unavailable slots

            return GestureDetector(
              onTap: isAvailable
                  ? () => onTimeSlotSelected(timeSlot)
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : isAvailable
                          ? Colors.white
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : isAvailable
                            ? AppColors.border
                            : Colors.grey[300]!,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  timeSlot,
                  style: isSelected
                      ? getBoldStyle(
                          color: Colors.white, fontFamily: FontConstant.cairo)
                      : getRegularStyle(
                          color: isAvailable
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontFamily: FontConstant.cairo),
                ),
              ).animate(target: isSelected ? 1 : 0, effects: cardSelection(
                duration: 200.ms,
                scaleBegin: const Offset(1, 1),
                scaleEnd: const Offset(1.05, 1.05),
              )),
            );
          }).toList(),
        ),
      ],
    );
  }
}