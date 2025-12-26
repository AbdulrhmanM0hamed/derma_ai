import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final Map<String, dynamic> patient;

  const MedicalHistoryWidget({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'التاريخ المرضي',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Patient Basic Info
          _buildInfoSection(
            title: 'المعلومات الأساسية',
            icon: Icons.person,
            color: Colors.blue,
            children: [
              _buildInfoRow('الاسم الكامل', patient['name']),
              _buildInfoRow('العمر', '${patient['age']} سنة'),
              _buildInfoRow('رقم الهاتف', patient['phone']),
              _buildInfoRow('الحالة الحالية', patient['condition']),
              _buildInfoRow('درجة الخطورة', patient['severity']),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Medical History
          _buildInfoSection(
            title: 'التاريخ المرضي',
            icon: Icons.medical_services,
            color: Colors.red,
            children: [
              _buildInfoRow('تاريخ أول زيارة', '2023-08-15'),
              _buildInfoRow('عدد الزيارات', '8 زيارات'),
              _buildInfoRow('آخر تشخيص', patient['condition']),
              _buildInfoRow('الحساسية المعروفة', 'لا توجد'),
              _buildInfoRow('الأدوية الحالية', 'هيدروكورتيزون كريم'),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Visit Timeline
          _buildInfoSection(
            title: 'سجل الزيارات',
            icon: Icons.timeline,
            color: Colors.green,
            children: [
              _buildTimelineItem(
                date: '2024-01-15',
                title: 'زيارة متابعة',
                description: 'تحسن ملحوظ في الحالة، تم تقليل جرعة الكورتيزون',
                status: 'مكتملة',
              ),
              _buildTimelineItem(
                date: '2024-01-01',
                title: 'زيارة طارئة',
                description: 'تفاقم في الأعراض، تم تغيير نوع العلاج',
                status: 'مكتملة',
              ),
              _buildTimelineItem(
                date: '2023-12-15',
                title: 'فحص دوري',
                description: 'فحص شامل للحالة، النتائج مرضية',
                status: 'مكتملة',
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Lab Results
          _buildInfoSection(
            title: 'نتائج التحاليل',
            icon: Icons.science,
            color: Colors.purple,
            children: [
              _buildLabResult('تحليل الدم الشامل', 'طبيعي', '2024-01-10', Colors.green),
              _buildLabResult('اختبار الحساسية', 'سلبي', '2024-01-05', Colors.green),
              _buildLabResult('فحص الفطريات', 'سلبي', '2023-12-20', Colors.green),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.print, size: 16),
                  label: const Text('طباعة التقرير'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('إضافة زيارة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(effects: fadeInScaleUp());
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String title,
    required String description,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
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
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabResult(String test, String result, String date, Color resultColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              test,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: resultColor.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: resultColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
