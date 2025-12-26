import 'package:derma_ai/core/utils/animations/app_animations.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate(effects: fadeInScaleUp(
                duration: 300.ms,
                begin: 0.8,
              )),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ).animate(effects: fadeIn(
                duration: 300.ms,
              )),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'سارة الأحمدي',
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontFamily: FontConstant.cairo,
            ),
          ).animate(effects: fadeIn(
            duration: 300.ms,
            delay: 150.ms,
          )),
          const SizedBox(height: 4),
          Text(
            'sarah.alahmadi@example.com',
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
          ).animate(effects: fadeIn(
            duration: 300.ms,
            delay: 150.ms,
          )),
          const SizedBox(height: 16),
          Animate(
            effects: fadeIn(
              duration: 300.ms,
              delay: 200.ms,
            ),
            child: CustomButton(
              text: 'تعديل الملف الشخصي',
              onPressed: () {
                // TODO: Navigate to edit profile page
              },
              width: 200,
              height: 48,
            ),
          ),
        ],
      ),
    );
  }
}
