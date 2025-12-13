import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
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
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA),
      body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return _buildLoadingState(l10n);
          }

          if (state is DoctorProfileError) {
            return _buildErrorState(context, state.message, l10n);
          }

          if (state is DoctorProfileLoaded) {
            return _buildProfileContent(context, state, isDark);
          }

          if (state is DoctorProfileUpdating) {
            return _buildProfileContent(
              context,
              DoctorProfileLoaded(state.currentProfile),
              isDark,
              isUpdating: true,
            );
          }

          return _buildLoadingState(l10n);
        },
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

  Widget _buildErrorState(BuildContext context, String message, AppLocalizations l10n) {
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  onEditTap: () {
                    // Navigate to edit profile
                  },
                ),

                // Transform to overlap with header
                Transform.translate(
                  offset: const Offset(0, -20),
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
            child: const Center(
              child: CustomProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
