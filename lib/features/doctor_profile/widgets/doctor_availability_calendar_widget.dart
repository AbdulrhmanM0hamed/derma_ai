import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorAvailabilityCalendarWidget extends StatefulWidget {
  final Map<String, dynamic> doctorData;

  const DoctorAvailabilityCalendarWidget({
    super.key,
    required this.doctorData,
  });

  @override
  State<DoctorAvailabilityCalendarWidget> createState() =>
      _DoctorAvailabilityCalendarWidgetState();
}

class _DoctorAvailabilityCalendarWidgetState
    extends State<DoctorAvailabilityCalendarWidget> {
  int selectedDayIndex = 0;
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<dynamic> availableDays =
        (widget.doctorData["availableDays"] as List?) ?? [];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withOpacity(0.05),
            blurRadius: 8,
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
                size: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "المواعيد المتاحة",
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          // Days Selector
          SizedBox(
            height: screenHeight * 0.12,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: availableDays.length > 7 ? 7 : availableDays.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: screenWidth * 0.02),
              itemBuilder: (context, index) {
                final day = availableDays[index] as Map<String, dynamic>;
                return _DayItem(
                  day: day,
                  isSelected: selectedDayIndex == index,
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                      selectedTimeSlot = null;
                    });
                  },
                );
              },
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideX(begin: 0.2),
          SizedBox(height: screenHeight * 0.02),
          // Time Slots
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _buildTimeSlots(availableDays, screenWidth, screenHeight),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }

  Widget _buildTimeSlots(
      List<dynamic> availableDays, double screenWidth, double screenHeight) {
    if (availableDays.isEmpty || selectedDayIndex >= availableDays.length) {
      return const _NoSlotsAvailable(message: "لا توجد أيام متاحة حالياً");
    }

    final selectedDay = availableDays[selectedDayIndex];
    final List<dynamic> timeSlots =
        (selectedDay["timeSlots"] as List?) ?? [];

    if (timeSlots.isEmpty) {
      return const _NoSlotsAvailable(
          message: "لا توجد مواعيد متاحة في هذا اليوم");
    }

    return Wrap(
      key: ValueKey<int>(selectedDayIndex), // Ensures widget rebuilds on day change
      spacing: screenWidth * 0.02,
      runSpacing: screenHeight * 0.01,
      children: timeSlots.map((slot) {
        final timeSlot = slot as Map<String, dynamic>;
        return _TimeSlotItem(
          timeSlot: timeSlot,
          isSelected: selectedTimeSlot == timeSlot["time"],
          onTap: () {
            if ((timeSlot["available"] as bool?) ?? false) {
              setState(() {
                selectedTimeSlot = timeSlot["time"];
              });
            }
          },
        );
      }).toList(),
    );
  }
}

class _DayItem extends StatelessWidget {
  final Map<String, dynamic> day;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayItem({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool hasSlots = ((day["timeSlots"] as List?) ?? []).isNotEmpty;
    final date = DateTime.parse(day["date"]);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.18,
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : hasSlots
                  ? Colors.white
                  : AppColors.textSecondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : hasSlots
                    ? AppColors.primary.withOpacity(0.3)
                    : AppColors.textSecondary.withOpacity(0.3),
            width: 1,
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
                color: isSelected
                    ? Colors.white
                    : hasSlots
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('d').format(date),
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: isSelected
                    ? Colors.white
                    : hasSlots
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeSlotItem extends StatelessWidget {
  final Map<String, dynamic> timeSlot;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlotItem({
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final String time = (timeSlot["time"] as String?) ?? "";
    final bool isAvailable = (timeSlot["available"] as bool?) ?? false;

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : isAvailable
                  ? Colors.white
                  : AppColors.textSecondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : isAvailable
                    ? AppColors.primary.withOpacity(0.3)
                    : AppColors.textSecondary.withOpacity(0.3),
            width: 1,
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
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _NoSlotsAvailable extends StatelessWidget {
  final String message;
  const _NoSlotsAvailable({required this.message});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_outlined,
            color: AppColors.textSecondary,
            size: screenWidth * 0.08,
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            message,
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
