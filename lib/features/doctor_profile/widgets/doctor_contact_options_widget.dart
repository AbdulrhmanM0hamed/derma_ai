import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';
import '../../video_call/presentation/pages/video_call_packages_page.dart';
import '../../chat/presentation/pages/chat_page.dart';

class DoctorContactOptionsWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorContactOptionsWidget({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
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
                Icons.contact_support_outlined,
                color: AppColors.primary,
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "خيارات التواصل",
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              // Video Call
              Expanded(
                child: _ContactOption(
                  icon: Icons.videocam,
                  label: "مكالمة فيديو",
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoCallPackagesPage(
                          doctorData: doctorData,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              // Chat
              Expanded(
                child: _ContactOption(
                  icon: Icons.chat,
                  label: "محادثة نصية",
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          doctorData: doctorData,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              // Phone Call
              Expanded(
                child: _ContactOption(
                  icon: Icons.phone,
                  label: "اتصال هاتفي",
                  color: AppColors.primary,
                  onTap: () {
                    // Handle phone call
                  },
                ),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.2),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }
}

class _ContactOption extends StatelessWidget {
  const _ContactOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.01, vertical: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: screenWidth * 0.05,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              label,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                color: color,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
