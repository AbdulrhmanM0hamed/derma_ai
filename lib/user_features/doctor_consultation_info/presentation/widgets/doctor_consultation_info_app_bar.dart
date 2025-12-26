import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class DoctorConsultationInfoAppBar extends StatelessWidget {
  const DoctorConsultationInfoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.tertiary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'استشارة طبيب',
          style: getBoldStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: FontConstant.cairo,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.tertiary,
                AppColors.tertiary.withValues(alpha: 0.8),
                AppColors.tertiary.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Animated background decorations
              Positioned(
                top: 40,
                right: 20,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ).animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 2500.ms)
                    .then()
                    .fadeOut(duration: 2500.ms),
              ),  
              Positioned(
                bottom: 20,
                left: 30,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ).animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 3500.ms)
                    .then()
                    .fadeOut(duration: 3500.ms),
              ),
              // Doctor consultation icon
              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: Icon(
                    Icons.medical_services_outlined,
                    size: 55,
                    color: Colors.white,
                  ),
                ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 2500.ms, color: Colors.white.withValues(alpha: 0.4))
                    .then()
                    .shimmer(duration: 2500.ms, color: Colors.white.withValues(alpha: 0.1)),
              ),
            ],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
