import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/appointment_model.dart';

class AppointmentTypeSelector extends StatelessWidget {
  final AppointmentType selectedType;
  final Function(AppointmentType) onTypeSelected;

  const AppointmentTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppointmentType.values.map((type) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: _AppointmentTypeCard(
            type: type,
            isSelected: selectedType == type,
            onTap: () => onTypeSelected(type),
          ),
        ).animate().fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: AppointmentType.values.indexOf(type) * 100),
        ).slideX(begin: 0.3);
      }).toList(),
    );
  }
}

class _AppointmentTypeCard extends StatelessWidget {
  final AppointmentType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _AppointmentTypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha:0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primary 
                    : AppColors.primary.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getTypeIcon(type),
                color: isSelected ? Colors.white : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.arabicName,
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 16,
                      color: isSelected ? AppColors.primary : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.description,
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(AppointmentType type) {
    switch (type) {
      case AppointmentType.consultation:
        return Icons.medical_services_outlined;
      case AppointmentType.followUp:
        return Icons.assignment_outlined;
      case AppointmentType.emergency:
        return Icons.emergency_outlined;
      case AppointmentType.checkup:
        return Icons.health_and_safety_outlined;
    }
  }
}
