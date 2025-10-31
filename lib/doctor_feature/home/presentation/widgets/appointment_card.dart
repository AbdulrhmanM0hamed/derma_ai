import 'package:flutter/material.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentDate;
  final String appointmentType;
  final ImageProvider? patientImage;

  const AppointmentCard({
    super.key,
    required this.patientName,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.appointmentType,
    this.patientImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientAvatar(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patientName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        appointmentDate,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        appointmentTime,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _getAppointmentTypeColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getAppointmentTypeIcon(),
                          size: 14,
                          color: _getAppointmentTypeColor(),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          appointmentType,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _getAppointmentTypeColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.video_call_rounded,
                    color: AppColors.primary,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.primary,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: patientImage != null
          ? CircleAvatar(backgroundImage: patientImage)
          : const Icon(
              Icons.person,
              color: AppColors.primary,
              size: 30,
            ),
    );
  }

  IconData _getAppointmentTypeIcon() {
    switch (appointmentType) {
      case 'Video Consultation':
        return Icons.videocam_rounded;
      case 'In-Person':
        return Icons.person_rounded;
      case 'Chat':
        return Icons.chat_rounded;
      default:
        return Icons.calendar_today_rounded;
    }
  }

  Color _getAppointmentTypeColor() {
    switch (appointmentType) {
      case 'Video Consultation':
        return Colors.blue;
      case 'In-Person':
        return Colors.green;
      case 'Chat':
        return Colors.purple;
      default:
        return AppColors.primary;
    }
  }
}
