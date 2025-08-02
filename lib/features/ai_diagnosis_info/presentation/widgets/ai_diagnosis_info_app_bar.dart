import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class AiDiagnosisInfoAppBar extends StatelessWidget {
  const AiDiagnosisInfoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'تشخيص الذكاء الاصطناعي',
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
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.8),
                AppColors.primary.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Animated background decorations
              Positioned(
                top: 50,
                right: 30,
                child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(
                      duration: 2000.ms,
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.2, 1.2),
                    )
                    .then()
                    .scale(
                      duration: 2000.ms,
                      begin: const Offset(1.2, 1.2),
                      end: const Offset(0.5, 0.5),
                    ),
              ),
              Positioned(
                bottom: 30,
                left: 40,
                child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(
                      duration: 3000.ms,
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.3, 1.3),
                    )
                    .then()
                    .scale(
                      duration: 3000.ms,
                      begin: const Offset(1.3, 1.3),
                      end: const Offset(0.5, 0.5),
                    ),
              ),
              // AI Brain Icon
              Center(
                child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Icon(
                        Icons.psychology_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: 2000.ms,
                      color: Colors.white.withValues(alpha: 0.3),
                    )
                    .then()
                    .shimmer(
                      duration: 2000.ms,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
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
