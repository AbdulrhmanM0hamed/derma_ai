import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/doctor_profile_model.dart';

class DoctorProfileHeader extends StatelessWidget {
  final DoctorProfileModel profile;
  final VoidCallback? onEditTap;

  const DoctorProfileHeader({super.key, required this.profile, this.onEditTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     AppColors.primary,
        //     AppColors.primary.withValues(alpha: 0.8),
        //     const Color(0xFF1565C0),
        //   ],
        // ),
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.primary.withValues(alpha: 0.3),
        //     blurRadius: 20,
        //     offset: const Offset(0, 10),
        //   ),
        // ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.profile,
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size20,
                      color: Colors.white,
                    ),
                  ),
                  if (onEditTap != null)
                    IconButton(
                      onPressed: onEditTap,
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Profile Picture
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child:
                        profile.profilePictureUrl != null &&
                                profile.profilePictureUrl!.isNotEmpty
                            ? ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: profile.profilePictureUrl!,
                                width: 106,
                                height: 106,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.primary,
                                    ),
                                errorWidget:
                                    (context, url, error) => const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.primary,
                                    ),
                              ),
                            )
                            : const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primary,
                            ),
                  ),
                ),
                // Verification Badge
                if (profile.isVerified)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Doctor Name
            Text(
              profile.displayName,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size22,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 4),

            // Specialty
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                profile.displaySpecialty,
                style: getMediumStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: FontSize.size14,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Rating and Experience Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoChip(
                    icon: Icons.star_rounded,
                    iconColor: Colors.amber,
                    value: profile.displayRating,
                    label: '(${profile.ratingCount})',
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.3),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  _buildInfoChip(
                    icon: Icons.work_outline_rounded,
                    iconColor: Colors.white,
                    value: '${profile.yearsOfExperience}+',
                    label: l10n.yearsExp,
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 24),

            // Status Badge
            // _buildStatusBadge(context, l10n),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 6),
        Text(
          value,
          style: getBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: FontSize.size18,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: FontSize.size12,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, AppLocalizations l10n) {
    Color badgeColor;
    String statusText;
    IconData statusIcon;

    if (profile.isApproved) {
      badgeColor = Colors.green;
      statusText = l10n.approved;
      statusIcon = Icons.check_circle;
    } else if (profile.isPending) {
      badgeColor = Colors.orange;
      statusText = l10n.pendingApproval;
      statusIcon = Icons.hourglass_empty;
    } else {
      badgeColor = Colors.red;
      statusText = l10n.rejected;
      statusIcon = Icons.cancel;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: badgeColor, size: 18),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: getMediumStyle(
              fontFamily: FontConstant.cairo,
              fontSize: FontSize.size12,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}
