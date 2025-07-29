import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorHeroSectionWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const DoctorHeroSectionWidget({
    super.key,
    required this.doctorData,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha:0.1),
            Colors.white,
          ],
          stops: const [0.0, 0.7],
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Photo
              Hero(
                tag: 'doctor_photo_${doctorData["id"]}',
                child: Container(
                  width: screenWidth * 0.28,
                  height: screenWidth * 0.28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha:0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: (doctorData["photo"] as String?) ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.white),
                      errorWidget: (context, url, error) => const Icon(Icons.person, color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms).scaleXY(),
              SizedBox(width: screenWidth * 0.04),
              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (doctorData["arabicName"] as String?) ?? "اسم الطبيب",
                      style: getBoldStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontFamily: FontConstant.cairo,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      (doctorData["englishName"] as String?) ?? "Doctor Name",
                      style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.2),
                    SizedBox(height: screenHeight * 0.01),
                    // Specialty
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.005),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        (doctorData["specialty"] as String?) ?? "التخصص",
                        style: getSemiBoldStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    SizedBox(height: screenHeight * 0.01),
                    // Rating and Experience
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          "${(doctorData["rating"] as double?) ?? 0.0}",
                          style: getBoldStyle(color: AppColors.textPrimary, fontSize: 14, fontFamily: FontConstant.cairo),
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        Text(
                          "(${(doctorData["reviewCount"] as int?) ?? 0} مراجعة)",
                          style: getRegularStyle(color: AppColors.textSecondary, fontSize: 12, fontFamily: FontConstant.cairo),
                        ),
                      ],
                    ).animate().fadeIn(delay: 350.ms),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      "${(doctorData["experience"] as int?) ?? 0} سنوات خبرة",
                      style: getRegularStyle(color: AppColors.textSecondary, fontSize: 12, fontFamily: FontConstant.cairo),
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),
              // Favorite Button
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textSecondary.withValues(alpha:0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.redAccent : AppColors.textSecondary,
                    size: screenWidth * 0.06,
                  ),
                ),
              ).animate().fadeIn(delay: 450.ms).scaleXY(),
            ],
          ),
        ],
      ),
    );
  }
}
