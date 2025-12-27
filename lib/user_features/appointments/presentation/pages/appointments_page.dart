import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'المواعيد',
          style: getBoldStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: FontConstant.cairo,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: getSemiBoldStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
          unselectedLabelStyle: getRegularStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
          tabs: const [
            Tab(text: 'القادمة'),
            Tab(text: 'المكتملة'),
            Tab(text: 'الملغية'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingAppointments(),
          _buildCompletedAppointments(),
          _buildCancelledAppointments(),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    final upcomingAppointments = [
      {
        'doctorName': 'د. أحمد محمد',
        'specialty': 'طبيب جلدية',
        'date': '2024-01-15',
        'time': '10:00 ص',
        'location': 'عيادة الجلدية المتخصصة',
        'image': 'assets/images/doctor1.jpg',
        'status': 'confirmed',
      },
      {
        'doctorName': 'د. فاطمة علي',
        'specialty': 'استشاري جلدية',
        'date': '2024-01-18',
        'time': '2:30 م',
        'location': 'مستشفى النور',
        'image': 'assets/images/doctor2.jpg',
        'status': 'pending',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: upcomingAppointments.length,
      itemBuilder: (context, index) {
        final appointment = upcomingAppointments[index];
        return _buildAppointmentCard(appointment, isUpcoming: true);
      },
    );
  }

  Widget _buildCompletedAppointments() {
    final completedAppointments = [
      {
        'doctorName': 'د. محمد حسن',
        'specialty': 'طبيب جلدية',
        'date': '2024-01-10',
        'time': '11:00 ص',
        'location': 'عيادة الجلدية',
        'image': 'assets/images/doctor3.jpg',
        'status': 'completed',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedAppointments.length,
      itemBuilder: (context, index) {
        final appointment = completedAppointments[index];
        return _buildAppointmentCard(appointment, isUpcoming: false);
      },
    );
  }

  Widget _buildCancelledAppointments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'لا توجد مواعيد ملغية',
            style: getSemiBoldStyle(
              color: Colors.grey[600]!,
              fontSize: 18,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'جميع مواعيدك محجوزة بنجاح',
            style: getRegularStyle(
              color: Colors.grey[500]!,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(
    Map<String, dynamic> appointment, {
    required bool isUpcoming,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(Icons.person, color: AppColors.primary, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['doctorName'],
                        style: getBoldStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment['specialty'],
                        style: getRegularStyle(
                          color: Colors.grey[600]!,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(appointment['status']),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          appointment['date'],
                          style: getMediumStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          appointment['time'],
                          style: getMediumStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[500], size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    appointment['location'],
                    style: getRegularStyle(
                      color: Colors.grey[600]!,
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ),
              ],
            ),
            if (isUpcoming) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1,
                        ),
                      ),
                      // color: AppColors.primary,
                      elevation: 0,
                      height: 45,
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'إلغاء',
                        style: getMediumStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      color: AppColors.primary,
                      elevation: 0,
                      height: 45,
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'إعادة جدولة',
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case 'confirmed':
        backgroundColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        text = 'مؤكد';
        break;
      case 'pending':
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        text = 'في الانتظار';
        break;
      case 'completed':
        backgroundColor = Colors.blue.withValues(alpha: 0.1);
        textColor = Colors.blue;
        text = 'مكتمل';
        break;
      default:
        backgroundColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
        text = 'غير محدد';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: getMediumStyle(
          color: textColor,
          fontSize: 12,
          fontFamily: FontConstant.cairo,
        ),
      ),
    );
  }
}
