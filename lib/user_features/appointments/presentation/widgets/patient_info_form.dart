import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';

class PatientInfoForm extends StatelessWidget {
  final String patientName;
  final String patientPhone;
  final String patientEmail;
  final Function(String) onNameChanged;
  final Function(String) onPhoneChanged;
  final Function(String) onEmailChanged;

  const PatientInfoForm({
    super.key,
    required this.patientName,
    required this.patientPhone,
    required this.patientEmail,
    required this.onNameChanged,
    required this.onPhoneChanged,
    required this.onEmailChanged,
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: 'الاسم الكامل',
            icon: Icons.person_outline,
            hintText: 'أدخل اسمك الكامل',
            initialValue: patientName,
            onChanged: onNameChanged,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى إدخال الاسم الكامل';
              }
              if (value.trim().length < 3) {
                return 'الاسم يجب أن يكون 3 أحرف على الأقل';
              }
              return null;
            },
            keyboardType: TextInputType.name,
          ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3),
          
          const SizedBox(height: 20),
          
          _buildFormField(
            label: 'رقم الهاتف',
            icon: Icons.phone_outlined,
            hintText: '05xxxxxxxx',
            initialValue: patientPhone,
            onChanged: onPhoneChanged,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى إدخال رقم الهاتف';
              }
              if (!RegExp(r'^05\d{8}$').hasMatch(value.trim())) {
                return 'رقم الهاتف غير صحيح (مثال: 0512345678)';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: 0.3),
          
          const SizedBox(height: 20),
          
          _buildFormField(
            label: 'البريد الإلكتروني',
            icon: Icons.email_outlined,
            hintText: 'example@email.com',
            initialValue: patientEmail,
            onChanged: onEmailChanged,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى إدخال البريد الإلكتروني';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                return 'البريد الإلكتروني غير صحيح';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.3),
          
          const SizedBox(height: 20),
          
          _buildPrivacyNote().animate().fadeIn(duration: 600.ms, delay: 300.ms),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required String hintText,
    required String initialValue,
    required Function(String) onChanged,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textAlign: TextAlign.right,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[500],
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha:0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security_outlined,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حماية البيانات',
                  style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'جميع بياناتك الشخصية محمية ومشفرة وفقاً لأعلى معايير الأمان الطبي',
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
