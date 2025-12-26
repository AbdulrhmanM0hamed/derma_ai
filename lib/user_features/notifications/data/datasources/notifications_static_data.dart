import '../models/notification_model.dart';

class NotificationsStaticData {
  static List<NotificationModel> getNotifications() {
    final now = DateTime.now();
    
    return [
      // نصيحة اليوم
      NotificationModel(
        id: 'tip_001',
        title: 'نصيحة اليوم: حماية البشرة من الشمس',
        message: 'استخدم واقي الشمس بعامل حماية SPF 30 أو أعلى يومياً، حتى في الأيام الغائمة. هذا يحمي بشرتك من الأشعة فوق البنفسجية الضارة.',
        type: NotificationType.tip,
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: false,
        metadata: {
          'category': 'skin_care',
          'priority': 'high',
        },
      ),

      // تذكير موعد
      NotificationModel(
        id: 'appointment_001',
        title: 'موعد قادم مع د. أحمد محمد',
        message: 'لديك موعد غداً الساعة 10:00 صباحاً في عيادة الأمراض الجلدية. لا تنس إحضار التقارير الطبية السابقة.',
        type: NotificationType.appointment,
        timestamp: now.subtract(const Duration(hours: 1)),
        isRead: false,
        metadata: {
          'doctor_id': 'doc_001',
          'appointment_time': '10:00 AM',
          'clinic_location': 'عيادة الأمراض الجلدية',
        },
      ),

      // تذكير دواء
      NotificationModel(
        id: 'medication_001',
        title: 'تذكير: حان وقت تناول الدواء',
        message: 'حان وقت تناول دواء الحساسية (سيتريزين 10 مجم). تناول قرص واحد مع كوب من الماء.',
        type: NotificationType.medication,
        timestamp: now.subtract(const Duration(minutes: 15)),
        isRead: false,
        metadata: {
          'medication_name': 'سيتريزين',
          'dosage': '10 مجم',
          'frequency': 'مرة يومياً',
        },
      ),

      // نتيجة تحليل
      NotificationModel(
        id: 'result_001',
        title: 'نتائج التحاليل جاهزة',
        message: 'نتائج تحليل الدم الشامل وفيتامين د جاهزة للمراجعة. يمكنك الآن عرضها من خلال التطبيق.',
        type: NotificationType.result,
        timestamp: now.subtract(const Duration(hours: 3)),
        isRead: true,
        metadata: {
          'test_types': ['تحليل دم شامل', 'فيتامين د'],
          'result_status': 'ready',
        },
      ),

      // تذكير عام
      NotificationModel(
        id: 'reminder_001',
        title: 'تذكير: فحص دوري للبشرة',
        message: 'حان وقت الفحص الدوري الشهري للبشرة. افحص أي تغييرات في الشامات أو البقع الجلدية.',
        type: NotificationType.reminder,
        timestamp: now.subtract(const Duration(hours: 5)),
        isRead: true,
        metadata: {
          'reminder_type': 'monthly_checkup',
          'next_reminder': now.add(const Duration(days: 30)),
        },
      ),

      // نصيحة صحية
      NotificationModel(
        id: 'tip_002',
        title: 'نصيحة: ترطيب البشرة في الشتاء',
        message: 'في فصل الشتاء، استخدم مرطب أكثر كثافة واشرب كمية كافية من الماء للحفاظ على رطوبة البشرة.',
        type: NotificationType.tip,
        timestamp: now.subtract(const Duration(hours: 8)),
        isRead: true,
        metadata: {
          'season': 'winter',
          'category': 'moisturizing',
        },
      ),

      // موعد مكالمة فيديو
      NotificationModel(
        id: 'appointment_002',
        title: 'مكالمة فيديو مع د. سارة أحمد',
        message: 'مكالمة فيديو مجدولة اليوم الساعة 3:00 مساءً. تأكد من اتصال الإنترنت وجهز الأسئلة مسبقاً.',
        type: NotificationType.appointment,
        timestamp: now.subtract(const Duration(hours: 12)),
        isRead: false,
        metadata: {
          'doctor_id': 'doc_002',
          'call_type': 'video',
          'duration': '30 minutes',
        },
      ),

      // تذكير شرب الماء
      NotificationModel(
        id: 'reminder_002',
        title: 'تذكير: اشرب الماء',
        message: 'لم تسجل شرب الماء منذ 3 ساعات. اشرب كوباً من الماء الآن للحفاظ على رطوبة جسمك وبشرتك.',
        type: NotificationType.reminder,
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
        metadata: {
          'reminder_type': 'hydration',
          'target_amount': '8 glasses',
        },
      ),

      // نصيحة غذائية
      NotificationModel(
        id: 'tip_003',
        title: 'نصيحة: أطعمة مفيدة للبشرة',
        message: 'تناول الأطعمة الغنية بأوميجا 3 مثل السلمون والجوز لتحسين صحة البشرة ونعومتها.',
        type: NotificationType.tip,
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
        metadata: {
          'category': 'nutrition',
          'foods': ['سلمون', 'جوز', 'أفوكادو'],
        },
      ),

      // تذكير موعد متابعة
      NotificationModel(
        id: 'reminder_003',
        title: 'تذكير: موعد المتابعة',
        message: 'لا تنس حجز موعد المتابعة مع طبيب الأمراض الجلدية خلال الأسبوع القادم لمراجعة تطور العلاج.',
        type: NotificationType.reminder,
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: false,
        metadata: {
          'follow_up_type': 'treatment_progress',
          'suggested_timeframe': '1 week',
        },
      ),

      // إشعار طوارئ
      NotificationModel(
        id: 'emergency_001',
        title: 'تحذير: أعراض تستدعي مراجعة فورية',
        message: 'إذا لاحظت تغيراً مفاجئاً في لون أو حجم الشامة، راجع الطبيب فوراً. هذا قد يكون علامة تحتاج عناية طبية.',
        type: NotificationType.emergency,
        timestamp: now.subtract(const Duration(days: 3)),
        isRead: true,
        metadata: {
          'severity': 'high',
          'symptoms': ['تغير لون الشامة', 'تغير الحجم'],
        },
      ),

      // نصيحة نوم
      NotificationModel(
        id: 'tip_004',
        title: 'نصيحة: النوم وصحة البشرة',
        message: 'احصل على 7-8 ساعات نوم يومياً. أثناء النوم، تتجدد خلايا البشرة وتصلح الأضرار.',
        type: NotificationType.tip,
        timestamp: now.subtract(const Duration(days: 3, hours: 5)),
        isRead: true,
        metadata: {
          'category': 'sleep',
          'recommended_hours': '7-8',
        },
      ),
    ];
  }

  static List<NotificationModel> getUnreadNotifications() {
    return getNotifications().where((notification) => !notification.isRead).toList();
  }

  static List<NotificationModel> getTodayNotifications() {
    final today = DateTime.now();
    return getNotifications().where((notification) {
      return notification.timestamp.day == today.day &&
             notification.timestamp.month == today.month &&
             notification.timestamp.year == today.year;
    }).toList();
  }

  static List<NotificationModel> getNotificationsByType(NotificationType type) {
    return getNotifications().where((notification) => notification.type == type).toList();
  }

  static int getUnreadCount() {
    return getUnreadNotifications().length;
  }
}
