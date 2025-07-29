import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorConsultationFeeWidget extends StatelessWidget {
  const DoctorConsultationFeeWidget({
    super.key,
    required this.doctorData,
    required this.onBookAppointment,
  });

  final Map<String, dynamic> doctorData;
  final VoidCallback onBookAppointment;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> consultationFee =
        (doctorData["consultationFee"] as Map<String, dynamic>?) ?? {};
    final bool emergencyAvailable =
        (doctorData["emergencyConsultation"] as bool?) ?? false;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha:0.1),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Emergency Consultation Toggle
            if (emergencyAvailable) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.03),
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha:0.05),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  border: Border.all(
                    color: Colors.red.withValues(alpha:0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.emergency_outlined,
                      color: Colors.red,
                      size: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "استشارة طارئة",
                            style: getSemiBoldStyle(
                              fontFamily: FontConstant.cairo,
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "متاح للحالات الطارئة",
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              color: Colors.red.withValues(alpha:0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: false,
                      onChanged: (value) {
                        // Handle emergency toggle
                      },
                      activeColor: Colors.red,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
            ],
            // Consultation Fee Display
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "رسوم الاستشارة",
                        style: getRegularStyle(
                          fontFamily: FontConstant.cairo,
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Row(
                        children: [
                          Text(
                            "${(consultationFee["amount"] as String?) ?? ""} ${(consultationFee["currency"] as String?) ?? ""}",
                            style: getBoldStyle(
                              fontFamily: FontConstant.cairo,
                              color: AppColors.primary,
                              fontSize: 20,
                            ),
                          ),
                          if (consultationFee["originalAmount"] != null) ...[
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              "/ جلسة",
                              style: getRegularStyle(
                                fontFamily: FontConstant.cairo,
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (consultationFee["originalAmount"] != null) ...[
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            Text(
                              "${(consultationFee["originalAmount"] as String?) ?? ""}",
                              style: getRegularStyle(
                                fontFamily: FontConstant.cairo,
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.005),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.01),
                              ),
                              child: Text(
                                "${(consultationFee["discount"] as String?) ?? ""}% خصم",
                                style: getSemiBoldStyle(
                                  fontFamily: FontConstant.cairo,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                // Book Appointment Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: onBookAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: screenWidth * 0.05,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "حجز موعد",
                          style: getSemiBoldStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
            SizedBox(height: screenHeight * 0.01),
            // Additional Info
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.textSecondary,
                  size: screenWidth * 0.03,
                ),
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: Text(
                    "يمكنك إلغاء أو تعديل الموعد حتى 24 ساعة قبل الموعد المحدد",
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.4),
          ],
        ),
      ),
    );
  }
}
