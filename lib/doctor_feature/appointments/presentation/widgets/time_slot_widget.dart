import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class TimeSlotWidget extends StatelessWidget {
  final Map<String, dynamic> timeSlot;
  final VoidCallback onTap;

  const TimeSlotWidget({
    super.key,
    required this.timeSlot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = timeSlot['available'] ?? false;
    final String? patientName = timeSlot['patient'];
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getBorderColor(),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timeSlot['time'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _getTextColor(),
              ),
            ),
            const SizedBox(height: 4),
            if (isAvailable)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 12,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'متاح',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 12,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'محجوز',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (patientName != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      patientName,
                      style: TextStyle(
                        fontSize: 8,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    ).animate(effects: fadeInScaleUp());
  }

  Color _getBackgroundColor() {
    final bool isAvailable = timeSlot['available'] ?? false;
    
    if (isAvailable) {
      return Colors.green.withOpacity(0.1);
    } else {
      return Colors.red.withOpacity(0.1);
    }
  }

  Color _getBorderColor() {
    final bool isAvailable = timeSlot['available'] ?? false;
    
    if (isAvailable) {
      return Colors.green.withOpacity(0.3);
    } else {
      return Colors.red.withOpacity(0.3);
    }
  }

  Color _getTextColor() {
    final bool isAvailable = timeSlot['available'] ?? false;
    
    if (isAvailable) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
