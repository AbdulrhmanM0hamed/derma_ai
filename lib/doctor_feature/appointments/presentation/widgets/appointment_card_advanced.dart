import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class AppointmentCardAdvanced extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onComplete;
  final bool showActions;
  final bool showCountdown;
  final bool isCompleted;
  final bool isCancelled;

  const AppointmentCardAdvanced({
    super.key,
    required this.appointment,
    required this.onTap,
    required this.onEdit,
    required this.onCancel,
    required this.onComplete,
    this.showActions = false,
    this.showCountdown = false,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _getBorderColor(),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                // Time Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _getTimeColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appointment['time'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getTimeColor(),
                    ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Patient Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['patientName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        appointment['type'],
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Status Badge
                _buildStatusBadge(),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Appointment Details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildDetailItem(
                        icon: Icons.access_time,
                        label: 'المدة',
                        value: '${appointment['duration']} دقيقة',
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 20),
                      _buildDetailItem(
                        icon: Icons.phone,
                        label: 'الهاتف',
                        value: appointment['phone'],
                        color: Colors.green,
                      ),
                    ],
                  ),
                  
                  if (showCountdown) ...[
                    const SizedBox(height: 12),
                    _buildCountdownWidget(),
                  ],
                  
                  if (appointment['notes'] != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 16,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              appointment['notes'],
                              style: TextStyle(
                                fontSize: 12,
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
            
            if (showActions || !isCompleted && !isCancelled) ...[
              const SizedBox(height: 16),
              _buildActionButtons(),
            ],
          ],
        ),
      ),
    ).animate(effects: fadeInSlide());
  }

  Widget _buildStatusBadge() {
    Color color;
    IconData icon;
    String status = appointment['status'];
    
    switch (status) {
      case 'قادم':
        color = Colors.blue;
        icon = Icons.schedule;
        break;
      case 'مكتمل':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'ملغي':
        color = Colors.red;
        icon = Icons.cancel;
        break;
      case 'جاري':
        color = Colors.orange;
        icon = Icons.play_circle;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownWidget() {
    // Calculate time until appointment
    final now = DateTime.now();
    final appointmentDateTime = DateTime.parse('${appointment['date']} ${appointment['time']}:00');
    final difference = appointmentDateTime.difference(now);
    
    String countdownText;
    Color countdownColor;
    
    if (difference.isNegative) {
      countdownText = 'انتهى الموعد';
      countdownColor = Colors.red;
    } else if (difference.inDays > 0) {
      countdownText = 'خلال ${difference.inDays} يوم';
      countdownColor = Colors.blue;
    } else if (difference.inHours > 0) {
      countdownText = 'خلال ${difference.inHours} ساعة';
      countdownColor = Colors.orange;
    } else if (difference.inMinutes > 0) {
      countdownText = 'خلال ${difference.inMinutes} دقيقة';
      countdownColor = Colors.red;
    } else {
      countdownText = 'الآن';
      countdownColor = Colors.green;
    }
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: countdownColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            size: 16,
            color: countdownColor,
          ),
          const SizedBox(width: 6),
          Text(
            countdownText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: countdownColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (isCompleted) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('عرض التفاصيل'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.repeat, size: 16),
              label: const Text('حجز متابعة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      );
    }
    
    if (isCancelled) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('عرض السبب'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('إعادة جدولة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      );
    }
    
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('تعديل'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.cancel, size: 16),
            label: const Text('إلغاء'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onComplete,
            icon: const Icon(Icons.check, size: 16),
            label: const Text('بدء'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  Color _getBorderColor() {
    if (isCancelled) return Colors.red.withOpacity(0.3);
    if (isCompleted) return Colors.green.withOpacity(0.3);
    
    switch (appointment['status']) {
      case 'جاري':
        return Colors.orange.withOpacity(0.3);
      case 'قادم':
        return Colors.blue.withOpacity(0.3);
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getTimeColor() {
    if (isCancelled) return Colors.red;
    if (isCompleted) return Colors.green;
    
    switch (appointment['status']) {
      case 'جاري':
        return Colors.orange;
      case 'قادم':
        return AppColors.primary;
      default:
        return Colors.grey;
    }
  }
}
