import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/constant/font_manger.dart';
import '../../../core/utils/constant/styles_manger.dart';
import '../../../core/utils/theme/app_colors.dart';

class DoctorReviewsWidget extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorReviewsWidget({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<dynamic> reviews = (doctorData["reviews"] as List<dynamic>?) ?? [];
    final Map<String, dynamic> ratingBreakdown =
        (doctorData["ratingBreakdown"] as Map<String, dynamic>?) ?? {};
    final double rating = (doctorData["rating"] as double?) ?? 0.0;
    final int reviewCount = (doctorData["reviewCount"] as int?) ?? 0;

    if (reviews.isEmpty) {
      return const SizedBox.shrink();
    }

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
            color: AppColors.textSecondary.withValues(alpha:0.05),
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
                Icons.star_rounded,
                color: Colors.amber,
                size: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "تقييمات المرضى",
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          _RatingSummary(
            rating: rating,
            reviewCount: reviewCount,
            ratingBreakdown: ratingBreakdown,
          ),
          SizedBox(height: screenHeight * 0.02),
          const Divider(),
          SizedBox(height: screenHeight * 0.01),
          ...reviews.take(3).map((review) {
            return _ReviewListItem(review: review as Map<String, dynamic>);
          }).toList().animate(interval: 100.ms).fadeIn(duration: 300.ms).slideY(begin: 0.2),
          if (reviews.length > 3) ...[
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: Show all reviews
                },
                child: Text(
                  "عرض جميع المراجعات",
                  style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1);
  }
}

class _RatingSummary extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final Map<String, dynamic> ratingBreakdown;

  const _RatingSummary({
    required this.rating,
    required this.reviewCount,
    required this.ratingBreakdown,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(
          color: Colors.amber.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
              ),
              _RatingBar(rating: rating, size: screenWidth * 0.04),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "$reviewCount مراجعة",
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                final starCount = 5 - index;
                final count = (ratingBreakdown["$starCount"] as int?) ?? 0;
                final total = reviewCount > 0 ? reviewCount : 1;
                final percentage = count / total;

                return Row(
                  children: [
                    Text(
                      '$starCount',
                      style: getRegularStyle(
                          fontFamily: FontConstant.cairo,
                          color: AppColors.textSecondary,
                          fontSize: 12),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: screenWidth * 0.01),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.amber,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      '${(percentage * 100).toStringAsFixed(0)}%',
                      style: getRegularStyle(
                          fontFamily: FontConstant.cairo,
                          color: AppColors.textSecondary,
                          fontSize: 12),
                    ),
                  ],
                );
              }).reversed.toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewListItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const _ReviewListItem({required this.review});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.05,
                backgroundImage:
                    NetworkImage((review["userAvatar"] as String?) ??
                        'https://via.placeholder.com/150'),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (review["userName"] as String?) ?? "اسم المستخدم",
                      style: getSemiBoldStyle(
                          fontFamily: FontConstant.cairo,
                          color: AppColors.textPrimary,
                          fontSize: 14),
                    ),
                    Row(
                      children: [
                        _RatingBar(
                            rating: (review["rating"] as num?)?.toDouble() ?? 0.0,
                            size: screenWidth * 0.035),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          (review["date"] as String?) ?? "",
                          style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              color: AppColors.textSecondary,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            (review["comment"] as String?) ?? "",
            style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.5),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  // TODO: Handle helpful vote
                },
                icon: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: AppColors.primary,
                  size: screenWidth * 0.04,
                ),
                label: Text(
                  "مفيد (${(review["helpfulCount"] as int?) ?? 0})",
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              TextButton.icon(
                onPressed: () {
                  // TODO: Handle not helpful vote
                },
                icon: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: AppColors.textSecondary,
                  size: screenWidth * 0.04,
                ),
                label: Text(
                  "غير مفيد",
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final double rating;
  final double size;

  const _RatingBar({required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star_rounded
              : index < rating
                  ? Icons.star_half_rounded
                  : Icons.star_outline_rounded,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }
}
