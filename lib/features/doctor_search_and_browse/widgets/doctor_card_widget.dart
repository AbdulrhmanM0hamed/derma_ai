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

    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: Key(doctor["id"].toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.01,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.06),
              Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.04),
              Icon(
                Icons.share_outlined,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.04),
              Icon(
                Icons.message_outlined,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          // Handle swipe actions
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
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
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            doctor["profileImage"] as String,
                            width: screenWidth * 0.2,
                            height: screenWidth * 0.2,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Icon(
                                  Icons.person,
                                  size: screenWidth * 0.1,
                                  color: Theme.of(context).iconTheme.color,
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
                            style: getSemiBoldStyle(
                              fontFamily: FontConstant.cairo,
                              color: Theme.of(context).textTheme.titleMedium?.color,
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
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            doctor["specialtyArabic"] as String,
                            style: getMediumStyle(
                              fontFamily: FontConstant.cairo,
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                              style: getSemiBoldStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textPrimary,
                                fontSize: 12,
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
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Theme.of(context).iconTheme.color,
                              size: screenWidth * 0.04,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              "${doctor["distance"]} كم",
                              style: getRegularStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textPrimary,
                                fontSize: 12,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الموعد التالي",
                              style: getMediumStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: 12,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              doctor["nextAvailable"] as String,
                              style: getBoldStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "رسوم الاستشارة",
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            doctor["consultationFee"] as String,
                            style: getSemiBoldStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
