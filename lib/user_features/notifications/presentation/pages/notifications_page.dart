import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/notification_model.dart';
import '../../data/datasources/notifications_static_data.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_filter_chips.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<NotificationModel> _notifications = [];
  List<NotificationModel> _filteredNotifications = [];
  NotificationType? _selectedFilter;
  bool _showOnlyUnread = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadNotifications() {
    setState(() {
      _notifications = NotificationsStaticData.getNotifications();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredNotifications = _notifications.where((notification) {
        bool matchesType = _selectedFilter == null || notification.type == _selectedFilter;
        bool matchesReadStatus = !_showOnlyUnread || !notification.isRead;
        return matchesType && matchesReadStatus;
      }).toList();
    });
  }

  void _onFilterChanged(NotificationType? filter) {
    setState(() {
      _selectedFilter = filter;
      _applyFilters();
    });
  }

  void _toggleUnreadFilter() {
    setState(() {
      _showOnlyUnread = !_showOnlyUnread;
      _applyFilters();
    });
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        _applyFilters();
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final unreadCount = NotificationsStaticData.getUnreadCount();
    
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Text(
            'الإشعارات',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$unreadCount',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            _showOnlyUnread ? Icons.mark_email_read : Icons.mark_email_unread,
            color: AppColors.primary,
          ),
          onPressed: _toggleUnreadFilter,
          tooltip: _showOnlyUnread ? 'عرض الكل' : 'غير المقروءة فقط',
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.grey[700]),
          onSelected: (value) {
            if (value == 'mark_all_read') {
              _markAllAsRead();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'mark_all_read',
              child: Row(
                children: [
                  const Icon(Icons.done_all, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'تحديد الكل كمقروء',
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تصفية حسب النوع',
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          NotificationFilterChips(
            selectedFilter: _selectedFilter,
            onFilterChanged: _onFilterChanged,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
  }

  Widget _buildNotificationsList() {
    if (_filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = _filteredNotifications[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: NotificationCard(
            notification: notification,
            onTap: () => _markAsRead(notification.id),
            onMarkAsRead: () => _markAsRead(notification.id),
          ),
        ).animate().fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: index * 100),
        ).slideX(begin: -0.3);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _showOnlyUnread ? 'لا توجد إشعارات غير مقروءة' : 'لا توجد إشعارات',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _showOnlyUnread 
                ? 'جميع إشعاراتك مقروءة'
                : 'ستظهر الإشعارات هنا عند وصولها',
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale();
  }
}
