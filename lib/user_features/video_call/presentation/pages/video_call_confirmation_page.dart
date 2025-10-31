import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/video_call_package_model.dart';

class VideoCallConfirmationPage extends StatelessWidget {
  final VideoCallBookingModel booking;

  const VideoCallConfirmationPage({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSuccessHeader(),
            const SizedBox(height: 24),
            _buildBookingDetails(),
            const SizedBox(height: 24),
            _buildDoctorInfo(),
            const SizedBox(height: 24),
            _buildPackageInfo(),
            const SizedBox(height: 24),
            _buildNextSteps(),
            const SizedBox(height: 32),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.grey[700]),
        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      title: Text(
        'تأكيد الحجز',
        style: getBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'تم حجز المكالمة بنجاح!',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 22,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم التواصل معك قريباً لتأكيد الموعد',
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().scale(duration: 600.ms).fadeIn();
  }

  Widget _buildBookingDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.videocam,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'تفاصيل الحجز',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow('رقم الحجز', booking.id),
          _buildDetailRow('نوع الخدمة', 'مكالمة فيديو'),
          _buildDetailRow('الباقة', booking.package.name),
          _buildDetailRow('المدة', booking.package.formattedDuration),
          _buildDetailRow(
            'التاريخ',
            DateFormat('EEEE، d MMMM yyyy', 'ar').format(booking.scheduledDate),
          ),
          _buildDetailRow('الوقت', booking.scheduledTime),
          _buildDetailRow('الحالة', booking.status.arabicName),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي التكلفة',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                booking.package.formattedPrice,
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الطبيب',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  booking.doctorPhoto,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
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
                      booking.doctorName,
                      style: getBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking.doctorSpecialty,
                      style: getRegularStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.3);
  }

  Widget _buildPackageInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ما تشمله الباقة',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...booking.package.features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature,
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3);
  }

  Widget _buildNextSteps() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
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
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'الخطوات التالية',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStepItem('1', 'سيتم إرسال رسالة تأكيد عبر الواتساب والإيميل'),
          _buildStepItem('2', 'سيتواصل معك الطبيب لتأكيد الموعد'),
          _buildStepItem('3', 'ستحصل على رابط المكالمة قبل الموعد بـ 15 دقيقة'),
          _buildStepItem('4', 'تأكد من وجود اتصال إنترنت جيد وقت المكالمة'),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: 0.3);
  }

  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'العودة للصفحة الرئيسية',
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
              // Navigate to appointments page
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'عرض مواعيدي',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.5);
  }
}
