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

    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        shadowColor: AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          
          ),
          child: Column(
            children: [
              // Top Row: Image and Basic Info
              Row(
                children: [
                  // Doctor Image
                  Hero(
                    tag: 'doctor_image_${doctorData["id"]}',
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: (doctorData["photo"] as String?) ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.secondary,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                              size: 40,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.secondary,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 100.ms).scale(delay: 100.ms),
                  const SizedBox(width: 16),
                  // Doctor Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor Name
                        Text(
                          (doctorData["arabicName"] as String?) ?? "اسم الطبيب",
                          style: getBoldStyle(
                            fontSize: 18,
                            fontFamily: FontConstant.cairo,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).animate().fadeIn(delay: 200.ms),
                        const SizedBox(height: 4),
                        // Specialty Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (doctorData["specialty"] as String?) ?? "التخصص",
                            style: getSemiBoldStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ).animate().fadeIn(delay: 250.ms),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Favorite Button
                  GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isFavorite ? Colors.red.withValues(alpha: 0.1) : AppColors.secondary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isFavorite ? Colors.red.withValues(alpha: 0.3) : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms).scale(delay: 300.ms),
                ],
              ),
              const SizedBox(height: 16),
              // Stats Row
              Row(
                children: [
                  // Rating
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.star_rounded,
                      iconColor: Colors.amber,
                      value: "${(doctorData["rating"] as double?) ?? 0.0}",
                      label: "التقييم",
                    ).animate().fadeIn(delay: 350.ms),
                  ),
                  const SizedBox(width: 12),
                  // Experience
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.work_outline,
                      iconColor: AppColors.primary,
                      value: "${(doctorData["experience"] as int?) ?? 0}",
                      label: "سنوات الخبرة",
                    ).animate().fadeIn(delay: 400.ms),
                  ),
                  const SizedBox(width: 12),
                  // Reviews
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.reviews_outlined,
                      iconColor: AppColors.tertiary,
                      value: "${(doctorData["reviewsCount"] as int?) ?? 0}",
                      label: "المراجعات",
                    ).animate().fadeIn(delay: 450.ms),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
     
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: getBoldStyle(
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
          ),
          Text(
            label,
            style: getBoldStyle(
            
              fontSize: 10,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
