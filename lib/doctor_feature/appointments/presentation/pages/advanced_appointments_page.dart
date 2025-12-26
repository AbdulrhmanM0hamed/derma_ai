import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../widgets/appointment_card_advanced.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/time_slot_widget.dart';

class AdvancedAppointmentsPage extends StatefulWidget {
  const AdvancedAppointmentsPage({super.key});

  @override
  State<AdvancedAppointmentsPage> createState() => _AdvancedAppointmentsPageState();
}

class _AdvancedAppointmentsPageState extends State<AdvancedAppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'إدارة المواعيد المتقدمة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showAddAppointmentDialog(),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _showCalendarView(),
            icon: const Icon(Icons.calendar_view_month, color: Colors.white),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabs: const [
            Tab(text: 'اليوم'),
            Tab(text: 'القادمة'),
            Tab(text: 'المكتملة'),
            Tab(text: 'الملغاة'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Quick Stats
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickStat(
                    'اليوم',
                    '8',
                    Icons.today,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildQuickStat(
                    'هذا الأسبوع',
                    '24',
                    Icons.date_range,
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildQuickStat(
                    'معدل الحضور',
                    '92%',
                    Icons.trending_up,
                    Colors.purple,
                  ),
                ),
                Expanded(
                  child: _buildQuickStat(
                    'متوسط الانتظار',
                    '5 دقائق',
                    Icons.timer,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTodayTab(),
                _buildUpcomingTab(),
                _buildCompletedTab(),
                _buildCancelledTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "appointments_fab",
        onPressed: () => _showAddAppointmentDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'موعد جديد',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate(effects: fadeInScaleUp());
  }

  Widget _buildTodayTab() {
    final todayAppointments = _getAppointmentsForDay(_selectedDay);
    
    return Column(
      children: [
        // Time Slots Overview
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'الفترات الزمنية اليوم',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _timeSlots.length,
                  itemBuilder: (context, index) {
                    final slot = _timeSlots[index];
                    return TimeSlotWidget(
                      timeSlot: slot,
                      onTap: () => _selectTimeSlot(slot),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Today's Appointments
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: todayAppointments.length,
            itemBuilder: (context, index) {
              final appointment = todayAppointments[index];
              return AppointmentCardAdvanced(
                appointment: appointment,
                onTap: () => _showAppointmentDetails(appointment),
                onEdit: () => _editAppointment(appointment),
                onCancel: () => _cancelAppointment(appointment),
                onComplete: () => _completeAppointment(appointment),
                showActions: true,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingTab() {
    final upcomingAppointments = _getAllAppointments()
        .where((apt) => apt['status'] == 'قادم')
        .toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: upcomingAppointments.length,
      itemBuilder: (context, index) {
        final appointment = upcomingAppointments[index];
        return AppointmentCardAdvanced(
          appointment: appointment,
          onTap: () => _showAppointmentDetails(appointment),
          onEdit: () => _editAppointment(appointment),
          onCancel: () => _cancelAppointment(appointment),
          onComplete: () => _completeAppointment(appointment),
          showCountdown: true,
        );
      },
    );
  }

  Widget _buildCompletedTab() {
    final completedAppointments = _getAllAppointments()
        .where((apt) => apt['status'] == 'مكتمل')
        .toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedAppointments.length,
      itemBuilder: (context, index) {
        final appointment = completedAppointments[index];
        return AppointmentCardAdvanced(
          appointment: appointment,
          onTap: () => _showAppointmentDetails(appointment),
          onEdit: () => _editAppointment(appointment),
          onCancel: () => _cancelAppointment(appointment),
          onComplete: () => _completeAppointment(appointment),
          isCompleted: true,
        );
      },
    );
  }

  Widget _buildCancelledTab() {
    final cancelledAppointments = _getAllAppointments()
        .where((apt) => apt['status'] == 'ملغي')
        .toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cancelledAppointments.length,
      itemBuilder: (context, index) {
        final appointment = cancelledAppointments[index];
        return AppointmentCardAdvanced(
          appointment: appointment,
          onTap: () => _showAppointmentDetails(appointment),
          onEdit: () => _editAppointment(appointment),
          onCancel: () => _cancelAppointment(appointment),
          onComplete: () => _completeAppointment(appointment),
          isCancelled: true,
        );
      },
    );
  }

  void _showCalendarView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Calendar
              Expanded(
                child: CalendarWidget(
                  selectedDay: _selectedDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    Navigator.pop(context);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  appointments: _getAllAppointments(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddAppointmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('موعد جديد'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'اسم المريض',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'نوع الاستشارة',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'التاريخ',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'الوقت',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add appointment logic
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails(Map<String, dynamic> appointment) {
    // Show appointment details
  }

  void _editAppointment(Map<String, dynamic> appointment) {
    // Edit appointment logic
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    // Cancel appointment logic
  }

  void _completeAppointment(Map<String, dynamic> appointment) {
    // Complete appointment logic
  }

  void _selectTimeSlot(Map<String, dynamic> slot) {
    // Select time slot logic
  }

  void _selectDate() {
    // Date picker logic
  }

  void _selectTime() {
    // Time picker logic
  }

  List<Map<String, dynamic>> _getAppointmentsForDay(DateTime day) {
    return _getAllAppointments().where((apt) {
      final aptDate = DateTime.parse(apt['date']);
      return aptDate.year == day.year &&
             aptDate.month == day.month &&
             aptDate.day == day.day;
    }).toList();
  }

  List<Map<String, dynamic>> _getAllAppointments() {
    return [
      {
        'id': '1',
        'patientName': 'فاطمة أحمد',
        'phone': '01234567890',
        'date': '2024-01-15',
        'time': '09:00',
        'duration': 30,
        'type': 'استشارة عامة',
        'status': 'قادم',
        'notes': 'مريضة جديدة تعاني من أكزيما',
      },
      {
        'id': '2',
        'patientName': 'محمد علي',
        'phone': '01234567891',
        'date': '2024-01-15',
        'time': '10:00',
        'duration': 45,
        'type': 'متابعة',
        'status': 'مكتمل',
        'notes': 'متابعة علاج الصدفية',
      },
      {
        'id': '3',
        'patientName': 'سارة محمود',
        'phone': '01234567892',
        'date': '2024-01-15',
        'time': '11:00',
        'duration': 30,
        'type': 'استشارة متخصصة',
        'status': 'ملغي',
        'notes': 'تم الإلغاء بسبب ظروف طارئة',
      },
    ];
  }

  final List<Map<String, dynamic>> _timeSlots = [
    {'time': '09:00', 'available': true, 'patient': null},
    {'time': '09:30', 'available': false, 'patient': 'فاطمة أحمد'},
    {'time': '10:00', 'available': false, 'patient': 'محمد علي'},
    {'time': '10:30', 'available': true, 'patient': null},
    {'time': '11:00', 'available': false, 'patient': 'سارة محمود'},
    {'time': '11:30', 'available': true, 'patient': null},
    {'time': '12:00', 'available': true, 'patient': null},
    {'time': '14:00', 'available': true, 'patient': null},
    {'time': '14:30', 'available': true, 'patient': null},
    {'time': '15:00', 'available': true, 'patient': null},
  ];
}
