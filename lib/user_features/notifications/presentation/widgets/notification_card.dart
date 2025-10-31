import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
    this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!notification.isRead && onMarkAsRead != null) {
          onMarkAsRead!();
        }
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead 
              ? Colors.white 
              : notification.color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead
                ? Colors.grey.withValues(alpha: 0.2)
                : notification.color.withValues(alpha: 0.3),
            width: notification.isRead ? 1 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildContent(),
            const SizedBox(height: 12),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: notification.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            notification.icon,
            color: notification.color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: notification.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification.typeArabicName,
                      style: getBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 10,
                        color: notification.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (!notification.isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                notification.title,
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 15,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        notification.message,
        style: getRegularStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 13,
          color: Colors.grey[700],
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 14,
              color: Colors.grey[500],
            ),
            const SizedBox(width: 4),
            Text(
              notification.timeAgo,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        if (notification.actionUrl != null || notification.metadata != null)
          Row(
            children: [
              if (_hasAction())
                GestureDetector(
                  onTap: () => _handleAction(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: notification.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: notification.color.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getActionText(),
                          style: getSemiBoldStyle(
                            fontFamily: FontConstant.cairo,
                            fontSize: 10,
                            color: notification.color,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: notification.color,
                        ),
                      ],
                    ),
                  ),
                ),
              if (!notification.isRead) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onMarkAsRead,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.done,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }

  bool _hasAction() {
    return notification.actionUrl != null || 
           (notification.metadata != null && 
            (notification.metadata!.containsKey('doctor_id') || 
             notification.metadata!.containsKey('appointment_time')));
  }

  String _getActionText() {
    switch (notification.type) {
      case NotificationType.appointment:
        return 'عرض الموعد';
      case NotificationType.result:
        return 'عرض النتائج';
      case NotificationType.medication:
        return 'تفاصيل الدواء';
      case NotificationType.tip:
        return 'اقرأ المزيد';
      default:
        return 'عرض التفاصيل';
    }
  }

  void _handleAction() {
    // Handle different action types based on notification type
    switch (notification.type) {
      case NotificationType.appointment:
        // Navigate to appointment details
        break;
      case NotificationType.result:
        // Navigate to test results
        break;
      case NotificationType.medication:
        // Navigate to medication details
        break;
      case NotificationType.tip:
        // Navigate to health tips
        break;
      default:
        // Default action
        break;
    }
  }
}
