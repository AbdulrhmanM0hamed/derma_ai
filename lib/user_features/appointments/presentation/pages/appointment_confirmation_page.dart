import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/appointment_model.dart';

class AppointmentConfirmationPage extends StatefulWidget {
  final AppointmentModel appointment;

  const AppointmentConfirmationPage({
    super.key,
    required this.appointment,
  });

  @override
  State<AppointmentConfirmationPage> createState() => _AppointmentConfirmationPageState();
}

class _AppointmentConfirmationPageState extends State<AppointmentConfirmationPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildSuccessHeader(),
              const SizedBox(height: 32),
              _buildAppointmentCard(),
              const SizedBox(height: 24),
              _buildDoctorCard(),
              const SizedBox(height: 24),
              _buildPatientCard(),
              const SizedBox(height: 24),
              _buildNextStepsCard(),
              const SizedBox(height: 32),
              _buildActionButtons(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha:0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 24),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Text(
                  'تم حجز الموعد بنجاح!',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'سيتم التواصل معك قريباً لتأكيد الموعد',
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تفاصيل الموعد',
                        style: getBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'رقم الحجز: ${widget.appointment.id}',
                        style: getRegularStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(widget.appointment.status).withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.appointment.status.arabicName,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 12,
                      color: _getStatusColor(widget.appointment.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            _buildAppointmentDetail(
              Icons.event_outlined,
              'التاريخ',
              DateFormat('EEEE، d MMMM yyyy', 'ar').format(widget.appointment.appointmentDate),
            ),
            const SizedBox(height: 16),
            _buildAppointmentDetail(
              Icons.access_time_outlined,
              'الوقت',
              widget.appointment.appointmentTime,
            ),
            const SizedBox(height: 16),
            _buildAppointmentDetail(
              Icons.medical_services_outlined,
              'نوع الموعد',
              widget.appointment.appointmentType,
            ),
            const SizedBox(height: 16),
            _buildAppointmentDetail(
              Icons.attach_money_outlined,
              'رسوم الاستشارة',
              '${widget.appointment.consultationFee.toInt()} ريال',
            ),
          ],
        ),
      ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 200.ms),
    );
  }

  Widget _buildDoctorCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.appointment.doctorPhoto,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.appointment.doctorName,
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.appointment.doctorSpecialty,
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.appointment.clinicAddress,
                          style: getRegularStyle(
                            fontFamily: FontConstant.cairo,
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().slideX(begin: -0.3, duration: 600.ms, delay: 300.ms),
    );
  }

  Widget _buildPatientCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
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
                  Icons.person_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'بيانات المريض',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPatientDetail('الاسم', widget.appointment.patientName),
            const SizedBox(height: 12),
            _buildPatientDetail('الهاتف', widget.appointment.patientPhone),
            const SizedBox(height: 12),
            _buildPatientDetail('البريد الإلكتروني', widget.appointment.patientEmail),
          ],
        ),
      ).animate().slideX(begin: 0.3, duration: 600.ms, delay: 400.ms),
    );
  }

  Widget _buildNextStepsCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha:0.05),
              AppColors.secondary.withValues(alpha:0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha:0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'الخطوات التالية',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...[
              '1. سيتم إرسال رسالة تأكيد على رقم الهاتف المسجل',
              '2. يرجى الحضور قبل 15 دقيقة من الموعد',
              '3. إحضار الهوية الشخصية وأي تقارير طبية سابقة',
              '4. في حالة الحاجة لإلغاء أو تعديل الموعد، يرجى التواصل مع العيادة',
            ].map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                step,
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            )),
          ],
        ),
      ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 500.ms),
    );
  }

  Widget _buildActionButtons() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'العودة للرئيسية',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // TODO: Implement add to calendar functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم إضافة الموعد للتقويم'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'إضافة للتقويم',
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).animate().slideY(begin: 0.5, duration: 600.ms, delay: 600.ms),
    );
  }

  Widget _buildAppointmentDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 18,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPatientDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.confirmed:
        return Colors.green;
      case AppointmentStatus.cancelled:
        return Colors.red;
      case AppointmentStatus.completed:
        return Colors.blue;
      case AppointmentStatus.rescheduled:
        return Colors.purple;
    }
  }
}
