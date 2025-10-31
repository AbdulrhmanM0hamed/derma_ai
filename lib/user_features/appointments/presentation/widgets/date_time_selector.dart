import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';

class DateTimeSelector extends StatefulWidget {
  final Map<String, dynamic> doctorData;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final Function(DateTime) onDateSelected;
  final Function(String) onTimeSlotSelected;

  const DateTimeSelector({
    super.key,
    required this.doctorData,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.onDateSelected,
    required this.onTimeSlotSelected,
  });

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  late List<DateTime> _availableDates;
  late Map<String, List<Map<String, dynamic>>> _timeSlotsByDate;

  @override
  void initState() {
    super.initState();
    _generateAvailableDates();
  }

  void _generateAvailableDates() {
    _availableDates = [];
    _timeSlotsByDate = {};
    
    final now = DateTime.now();
    final workingHours = widget.doctorData['workingHours'] as Map<String, dynamic>? ?? {};
    
    // Generate next 30 days
    for (int i = 1; i <= 30; i++) {
      final date = now.add(Duration(days: i));
      final dayName = _getDayName(date.weekday);
      
      if (workingHours[dayName]?['available'] == true) {
        _availableDates.add(date);
        _timeSlotsByDate[DateFormat('yyyy-MM-dd').format(date)] = 
            _generateTimeSlotsForDate(date, workingHours[dayName]);
      }
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'monday';
      case 2: return 'tuesday';
      case 3: return 'wednesday';
      case 4: return 'thursday';
      case 5: return 'friday';
      case 6: return 'saturday';
      case 7: return 'sunday';
      default: return 'sunday';
    }
  }

  List<Map<String, dynamic>> _generateTimeSlotsForDate(
    DateTime date, 
    Map<String, dynamic> workingHours
  ) {
    final slots = <Map<String, dynamic>>[];
    final startTime = workingHours['start'] as String? ?? '9:00 AM';
    final endTime = workingHours['end'] as String? ?? '5:00 PM';
    
    // Convert to 24-hour format and generate 30-minute slots
    final start = _parseTime(startTime);
    final end = _parseTime(endTime);
    
    DateTime current = DateTime(date.year, date.month, date.day, start.hour, start.minute);
    final endDateTime = DateTime(date.year, date.month, date.day, end.hour, end.minute);
    
    while (current.isBefore(endDateTime)) {
      // Skip lunch break (12:00-13:00)
      if (current.hour != 12) {
        slots.add({
          'time': DateFormat('h:mm a', 'ar').format(current),
          'available': _isSlotAvailable(current),
        });
      }
      current = current.add(const Duration(minutes: 30));
    }
    
    return slots;
  }

  DateTime _parseTime(String timeStr) {
    final parts = timeStr.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    
    if (parts[1].toLowerCase() == 'pm' && hour != 12) {
      hour += 12;
    } else if (parts[1].toLowerCase() == 'am' && hour == 12) {
      hour = 0;
    }
    
    return DateTime(2023, 1, 1, hour, minute);
  }

  bool _isSlotAvailable(DateTime slot) {
    // Simulate some slots being unavailable
    return slot.minute == 0 || slot.minute == 30;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateSelector(),
        const SizedBox(height: 24),
        if (widget.selectedDate != null) _buildTimeSlotSelector(),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'اختر التاريخ',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _availableDates.length,
              itemBuilder: (context, index) {
                final date = _availableDates[index];
                final isSelected = widget.selectedDate != null &&
                    DateFormat('yyyy-MM-dd').format(widget.selectedDate!) ==
                        DateFormat('yyyy-MM-dd').format(date);
                
                return Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: _DateCard(
                    date: date,
                    isSelected: isSelected,
                    onTap: () => widget.onDateSelected(date),
                  ),
                ).animate().fadeIn(
                  duration: 500.ms,
                  delay: Duration(milliseconds: index * 50),
                ).slideY(begin: 0.3);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    final dateKey = DateFormat('yyyy-MM-dd').format(widget.selectedDate!);
    final timeSlots = _timeSlotsByDate[dateKey] ?? [];
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'اختر الوقت',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (timeSlots.isEmpty)
            _buildNoSlotsMessage()
          else
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: timeSlots.map((slot) {
                final isSelected = widget.selectedTimeSlot == slot['time'];
                final isAvailable = slot['available'] as bool;
                
                return _TimeSlotCard(
                  time: slot['time'],
                  isSelected: isSelected,
                  isAvailable: isAvailable,
                  onTap: isAvailable 
                      ? () => widget.onTimeSlotSelected(slot['time'])
                      : null,
                );
              }).toList(),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildNoSlotsMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_outlined,
            color: Colors.grey[600],
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'لا توجد مواعيد متاحة في هذا اليوم',
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateCard({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E', 'ar').format(date),
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('d').format(date),
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              DateFormat('MMM', 'ar').format(date),
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 10,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeSlotCard extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;

  const _TimeSlotCard({
    required this.time,
    required this.isSelected,
    required this.isAvailable,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary 
              : isAvailable 
                  ? Colors.grey[50] 
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? AppColors.primary 
                : isAvailable 
                    ? Colors.grey[300]! 
                    : Colors.grey[400]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          time,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: isSelected 
                ? Colors.white 
                : isAvailable 
                    ? Colors.black87 
                    : Colors.grey[600],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
