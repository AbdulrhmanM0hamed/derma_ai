import 'package:derma_ai/core/utils/animations/app_animations.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';


class DatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final int daysToShow;

  const DatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.daysToShow = 14,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late ScrollController _scrollController;
  late List<DateTime> _dates;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _generateDates();

    // Scroll to selected date initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _generateDates() {
    final now = DateTime.now();
    _dates = List.generate(widget.daysToShow, (index) {
      return DateTime(now.year, now.month, now.day + index);
    });
  }

  void _scrollToSelectedDate() {
    final selectedIndex = _dates.indexWhere((date) =>
        date.year == widget.selectedDate.year &&
        date.month == widget.selectedDate.month &&
        date.day == widget.selectedDate.day);

    if (selectedIndex != -1) {
      final itemWidth = 80.0; // Approximate width of each date item
      final screenWidth = MediaQuery.of(context).size.width;
      final offset = (selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          offset.clamp(0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = date.year == widget.selectedDate.year &&
              date.month == widget.selectedDate.month &&
              date.day == widget.selectedDate.day;

          final isToday = date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day;

          return GestureDetector(
            onTap: () => widget.onDateSelected(date),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 70,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date), // Day of week (Mon, Tue, etc.)
                    style: getRegularStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday && !isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : isSelected
                              ? Colors.white.withOpacity(0.2)
                              : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : isToday
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('MMM').format(date), // Month (Jan, Feb, etc.)
                    style: getRegularStyle(
                      fontSize: 12,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ],
              ),
            ).animate(target: isSelected ? 1 : 0, effects: cardSelection(
              duration: 200.ms,
              scaleBegin: const Offset(1, 1),
              scaleEnd: const Offset(1.05, 1.05),
            )),
          );
        },
      ),
    );
  }
}