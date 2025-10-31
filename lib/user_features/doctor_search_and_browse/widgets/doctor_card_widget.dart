import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DoctorCardWidget extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onMessage;
  final String? heroTagSuffix;

  const DoctorCardWidget({
    super.key,
    required this.doctor,
    required this.onTap,
    required this.onFavorite,
    required this.onShare,
    required this.onMessage,
    this.heroTagSuffix,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.008,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'doctor_${doctor["id"]}${heroTagSuffix ?? ""}',
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.network(
                          doctor["profileImage"] as String,
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[100],
                            child: Icon(
                              Icons.person,
                              size: screenWidth * 0.1,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor["nameArabic"] as String,
                          style: getBoldStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          doctor["nameEnglish"] as String,
                          style: getRegularStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenHeight * 0.008),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            doctor["specialtyArabic"] as String,
                            style: getSemiBoldStyle(
                              fontFamily: FontConstant.cairo,
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: screenWidth * 0.04,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            doctor["rating"].toString(),
                            style: getBoldStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        "${doctor["reviewCount"]} تقييم",
                        style: getRegularStyle(
                          fontFamily: FontConstant.cairo,
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey[600],
                            size: screenWidth * 0.035,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            "${doctor["distance"]} كم",
                            style: getRegularStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الموعد التالي",
                            style: getRegularStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            doctor["nextAvailable"] as String,
                            style: getBoldStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رسوم الاستشارة",
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            doctor["consultationFee"] as String,
                            style: getBoldStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      icon: doctor["isFavorite"] == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      label: "المفضلة",
                      color: doctor["isFavorite"] == true
                          ? Colors.red
                          : Colors.grey[600]!,
                      onTap: onFavorite,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      icon: Icons.share_outlined,
                      label: "مشاركة",
                      color: Colors.grey[600]!,
                      onTap: onShare,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      icon: Icons.message_outlined,
                      label: "رسالة",
                      color: AppColors.primary,
                      onTap: onMessage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.025,
          horizontal: screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: screenWidth * 0.04,
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              label,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                color: color,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
