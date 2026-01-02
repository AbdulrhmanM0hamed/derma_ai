import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/services/service_locatores.dart' as di;
import '../bloc/doctor_profile_cubit.dart';
import '../bloc/doctor_profile_state.dart';
import '../widgets/doctor_profile_widgets.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<DoctorProfileCubit>()..getDoctorProfile(),
      child: const _DoctorProfileView(),
    );
  }
}

class _DoctorProfileView extends StatelessWidget {
  const _DoctorProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA),
      body: BlocListener<DoctorProfileCubit, DoctorProfileState>(
        listener: (context, state) {
          if (state is DoctorProfileUpdateError) {
            CustomSnackbar.showError(context: context, message: state.message);
          }
        },
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            final cubit = context.read<DoctorProfileCubit>();
            if (state is DoctorProfileLoading) {
              return _buildLoadingState(l10n);
            }

            if (state is DoctorProfileError) {
              return _buildErrorState(context, state.message, l10n);
            }

            if (state is DoctorProfileUpdateError) {
              return _buildProfileContent(
                context,
                DoctorProfileLoaded(state.currentProfile),
                isDark,
                editProfile: () => _showProfilePictureOptions(context, cubit),
              );
            }

            if (state is DoctorProfileLoaded) {
              return _buildProfileContent(
                context,
                state,
                isDark,
                editProfile: () => _showProfilePictureOptions(context, cubit),
              );
            }

            if (state is DoctorProfileUpdating) {
              return _buildProfileContent(
                context,
                DoctorProfileLoaded(state.currentProfile),
                isDark,
                isUpdating: true,
                editProfile: () => _showProfilePictureOptions(context, cubit),
              );
            }

            return _buildLoadingState(l10n);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            l10n.loadingProfile,
            style: getMediumStyle(
              fontFamily: FontConstant.cairo,
              fontSize: FontSize.size14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String message,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.errorLoadingProfile,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size18,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DoctorProfileCubit>().getDoctorProfile();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    DoctorProfileLoaded state,
    bool isDark, {
    bool isUpdating = false,
    required Function() editProfile,
  }) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => context.read<DoctorProfileCubit>().refreshProfile(),
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header with gradient
                DoctorProfileHeader(
                  profile: state.profile,
                  onEditTap: editProfile,
                ),

                // Transform to overlap with header
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: Column(
                    children: [
                      // Stats Row
                      DoctorStatsRow(profile: state.profile),

                      const SizedBox(height: 24),

                      // Info Sections
                      DoctorInfoSection(profile: state.profile),

                      const SizedBox(height: 24),

                      // Settings Section
                      const DoctorSettingsSection(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Loading overlay when updating
        if (isUpdating)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(child: CustomProgressIndicator()),
          ),
      ],
    );
  }

  void _showProfilePictureOptions(
    BuildContext context,
    DoctorProfileCubit cubit,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[700] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  l10n.changeProfilePicture,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // Gallery option
                _buildOptionTile(
                  context: context,
                  icon: Icons.photo_library_rounded,
                  title: l10n.chooseImageSource,
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      cubit.uploadProfilePicture(image.path);
                    }
                  },
                  isDark: isDark,
                ),

                const SizedBox(height: 12),

                // Camera option
                _buildOptionTile(
                  context: context,
                  icon: Icons.camera_alt_rounded,
                  title: l10n.takePhoto,
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      cubit.uploadProfilePicture(image.path);
                    }
                  },
                  isDark: isDark,
                ),

                const SizedBox(height: 12),

                // Delete option
                _buildOptionTile(
                  context: context,
                  icon: Icons.delete_rounded,
                  title: l10n.takePhoto,
                  onTap: () {
                    Navigator.pop(context);
                    cubit.deleteProfilePicture();
                  },
                  isDark: isDark,
                  isDestructive: true,
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color:
              isDark
                  ? Colors.grey[850]?.withValues(alpha: 0.5)
                  : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    isDestructive
                        ? Colors.red.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: getMediumStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: FontSize.size16,
                  color: isDestructive ? Colors.red : AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
