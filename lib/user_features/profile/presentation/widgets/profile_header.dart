import 'package:cached_network_image/cached_network_image.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/user_features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileState state;
  final VoidCallback onEditProfileTap;
  final VoidCallback onProfilePictureTap;

  const ProfileHeader({
    super.key,
    required this.state,
    required this.onEditProfileTap,
    required this.onProfilePictureTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 340,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // SVG Background instead of gradient
          SizedBox(
            height: 170,
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/images/header_profile.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Profile card
          Positioned(
            top: 145,
            left: 16,
            right: 16,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildAvatar(context),
                        const SizedBox(width: 16),
                        _buildUserInfo(context, l10n),
                      ],
                    ),
                    _buildStats(l10n),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              CircleAvatar(
                key: ValueKey(
                  state is ProfileSuccess
                      ? (state as ProfileSuccess)
                              .userProfile
                              .profilePictureUrl ??
                          'no-picture'
                      : 'loading',
                ),
                radius: 32,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    state is ProfileSuccess &&
                            (state as ProfileSuccess)
                                    .userProfile
                                    .profilePictureUrl !=
                                null
                        ? CachedNetworkImageProvider(
                          (state as ProfileSuccess)
                              .userProfile
                              .profilePictureUrl!,
                        )
                        : null,
                child:
                    state is ProfileSuccess &&
                            (state as ProfileSuccess)
                                    .userProfile
                                    .profilePictureUrl ==
                                null
                        ? Text(
                          (state as ProfileSuccess)
                                  .userProfile
                                  .fullName
                                  .isNotEmpty
                              ? (state as ProfileSuccess)
                                  .userProfile
                                  .fullName[0]
                                  .toUpperCase()
                              : 'U',
                          style: getBoldStyle(
                            fontSize: 24,
                            color: AppColors.primary,
                            fontFamily: FontConstant.cairo,
                          ),
                        )
                        : state is ProfileLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Icon(Icons.person, size: 35, color: Colors.grey[600]),
              ),
              if (state is ProfileUpdating)
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (state is ProfileSuccess)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onProfilePictureTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, AppLocalizations l10n) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state is ProfileSuccess
                ? (state as ProfileSuccess).userProfile.displayName
                : state is ProfileLoading
                ? l10n.loadingData
                : l10n.user,
            style: getBoldStyle(fontFamily: FontConstant.cairo, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            state is ProfileSuccess
                ? '${l10n.patientId}: #${(state as ProfileSuccess).userProfile.patientId}'
                : '${l10n.patientId}: #---',
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
            width: 130,
            height: 30,
            onPressed: state is ProfileSuccess ? onEditProfileTap : null,
            text: l10n.editProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildStats(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('12', l10n.appointmentsCount),
          _buildStatItem('5', l10n.savedDoctors),
          _buildStatItem('8', l10n.ratingsCount),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: getBoldStyle(fontFamily: FontConstant.cairo, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: getMediumStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[650],
          ),
        ),
      ],
    );
  }
}
