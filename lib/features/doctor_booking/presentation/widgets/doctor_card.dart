import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/utils/animations/app_animations.dart';

class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String hospital;
  final String experience;
  final double consultationFee;
  final bool isAvailable;
  final String? about;
  final List<String>? education;
  final List<String>? services;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.hospital,
    required this.experience,
    required this.consultationFee,
    this.isAvailable = true,
    this.about,
    this.education,
    this.services,
  });
}

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;
  final bool isHorizontal;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return isHorizontal ? _buildHorizontalCard(context) : _buildVerticalCard(context);
  }

  Widget _buildHorizontalCard(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDoctorAvatar(size: 80),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            doctor.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildAvailabilityIndicator(context),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: getBoldStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${doctor.rating}',
                          style: getBoldStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${doctor.reviewCount})',
                          style: getRegularStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${doctor.consultationFee.toStringAsFixed(0)}',
                          style: getBoldStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(effects: fadeInSlide(
      duration: 300.ms,
      curve: Curves.easeOut,
      beginY: 0.1,
    ));
  }

  Widget _buildVerticalCard(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildAvailabilityIndicator(context),
                ],
              ),
              _buildDoctorAvatar(size: 100),
              const SizedBox(height: 12),
              Text(
                doctor.name,
                style: getBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                doctor.specialty,
                style: getBoldStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontFamily: FontConstant.cairo,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${doctor.rating}',
                    style: getBoldStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${doctor.reviewCount})',
                    style: getRegularStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '\$${doctor.consultationFee.toStringAsFixed(0)}',
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
    ).animate(effects: fadeInSlide(
      duration: 300.ms,
      curve: Curves.easeOut,
      beginY: 0.1,
    ));
  }

  Widget _buildDoctorAvatar({required double size}) {
    return Hero(
      tag: 'doctor_${doctor.id}',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: CachedNetworkImage(
            imageUrl: doctor.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.border.withValues(alpha: 0.2),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.border.withValues(alpha: 0.2),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: doctor.isAvailable ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: doctor.isAvailable ? AppColors.success : AppColors.error,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            doctor.isAvailable ? AppLocalizations.of(context)!.available : AppLocalizations.of(context)!.unavailable,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: doctor.isAvailable ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}