import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class AppointmentTimeline extends StatelessWidget {
  final List<TimelineAppointment> appointments;

  const AppointmentTimeline({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'جدول المواعيد اليوم',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ...appointments.asMap().entries.map((entry) {
            final index = entry.key;
            final appointment = entry.value;
            final isLast = index == appointments.length - 1;
            
            return _buildTimelineItem(appointment, isLast, index);
          }).toList(),
        ],
      ),
    ).animate(effects: fadeInSlide(delay: const Duration(milliseconds: 500)));
  }

  Widget _buildTimelineItem(TimelineAppointment appointment, bool isLast, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: appointment.status == AppointmentStatus.completed
                    ? Colors.green
                    : appointment.status == AppointmentStatus.current
                        ? AppColors.primary
                        : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: Colors.grey.shade200,
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Appointment content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appointment.status == AppointmentStatus.current
                  ? AppColors.primary.withOpacity(0.05)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: appointment.status == AppointmentStatus.current
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appointment.time,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: appointment.status == AppointmentStatus.current
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(appointment.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStatusText(appointment.status),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(appointment.status),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  appointment.patientName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appointment.condition,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (appointment.notes != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 14,
                          color: Colors.blue.shade600,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            appointment.notes!,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ).animate(effects: fadeInSlide(
      delay: Duration(milliseconds: 600 + (index * 100)),
    ));
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.completed:
        return Colors.green;
      case AppointmentStatus.current:
        return AppColors.primary;
      case AppointmentStatus.upcoming:
        return Colors.orange;
      case AppointmentStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.completed:
        return 'مكتمل';
      case AppointmentStatus.current:
        return 'جاري';
      case AppointmentStatus.upcoming:
        return 'قادم';
      case AppointmentStatus.cancelled:
        return 'ملغي';
    }
  }
}

class TimelineAppointment {
  final String time;
  final String patientName;
  final String condition;
  final AppointmentStatus status;
  final String? notes;

  TimelineAppointment({
    required this.time,
    required this.patientName,
    required this.condition,
    required this.status,
    this.notes,
  });
}

enum AppointmentStatus {
  completed,
  current,
  upcoming,
  cancelled,
}
