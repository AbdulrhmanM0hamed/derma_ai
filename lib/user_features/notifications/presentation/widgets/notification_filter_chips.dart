import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../data/models/notification_model.dart';

class NotificationFilterChips extends StatelessWidget {
  final NotificationType? selectedFilter;
  final Function(NotificationType?) onFilterChanged;

  const NotificationFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'type': null, 'label': 'الكل', 'icon': Icons.all_inclusive},
      {'type': NotificationType.tip, 'label': 'نصائح', 'icon': Icons.lightbulb},
      {'type': NotificationType.appointment, 'label': 'مواعيد', 'icon': Icons.calendar_today},
      {'type': NotificationType.reminder, 'label': 'تذكيرات', 'icon': Icons.alarm},
      {'type': NotificationType.medication, 'label': 'أدوية', 'icon': Icons.medication},
      {'type': NotificationType.result, 'label': 'نتائج', 'icon': Icons.assignment_turned_in},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final type = filter['type'] as NotificationType?;
          final label = filter['label'] as String;
          final icon = filter['icon'] as IconData;
          final isSelected = selectedFilter == type;
          
          return Container(
            margin: const EdgeInsets.only(left: 8),
            child: FilterChip(
              selected: isSelected,
              onSelected: (_) => onFilterChanged(type),
              avatar: Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
              label: Text(
                label,
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              ),
              backgroundColor: Colors.grey[100],
              selectedColor: _getColorForType(type),
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected 
                    ? _getColorForType(type)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getColorForType(NotificationType? type) {
    if (type == null) return Colors.blue;
    
    switch (type) {
      case NotificationType.appointment:
        return Colors.blue;
      case NotificationType.reminder:
        return Colors.orange;
      case NotificationType.tip:
        return Colors.green;
      case NotificationType.result:
        return Colors.purple;
      case NotificationType.emergency:
        return Colors.red;
      case NotificationType.medication:
        return Colors.teal;
      case NotificationType.general:
        return Colors.grey;
    }
  }
}
