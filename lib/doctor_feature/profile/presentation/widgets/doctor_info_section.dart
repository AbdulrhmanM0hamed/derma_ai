import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/doctor_profile_model.dart';

class DoctorInfoSection extends StatelessWidget {
  final DoctorProfileModel profile;

  const DoctorInfoSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Information Section
          _buildSectionHeader(
            context: context,
            title: l10n.personalInformation,
            icon: Icons.person_outline_rounded,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            context: context,
            isDark: isDark,
            children: [
              _buildInfoRow(
                context: context,
                icon: Icons.badge_outlined,
                label: l10n.fullName,
                value: profile.fullName.isNotEmpty ? profile.fullName : l10n.notProvided,
                isDark: isDark,
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context: context,
                icon: Icons.medical_services_outlined,
                label: l10n.specialty,
                value: profile.specialty ?? l10n.notProvided,
                isDark: isDark,
              ),
              if (profile.subSpecialty != null) ...[
                _buildDivider(isDark),
                _buildInfoRow(
                  context: context,
                  icon: Icons.medical_information_outlined,
                  label: l10n.subSpecialty,
                  value: profile.subSpecialty!,
                  isDark: isDark,
                ),
              ],
              _buildDivider(isDark),
              _buildInfoRow(
                context: context,
                icon: Icons.assignment_ind_outlined,
                label: l10n.licenseNumber,
                value: profile.licenseNumber ?? l10n.notProvided,
                isDark: isDark,
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context: context,
                icon: Icons.language_outlined,
                label: l10n.languagesSpoken,
                value: profile.languagesSpoken ?? l10n.notProvided,
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Professional Information Section
          _buildSectionHeader(
            context: context,
            title: l10n.professionalInformation,
            icon: Icons.work_outline_rounded,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            context: context,
            isDark: isDark,
            children: [
              _buildInfoRow(
                context: context,
                icon: Icons.school_outlined,
                label: l10n.medicalSchool,
                value: profile.medicalSchool ?? l10n.notProvided,
                isDark: isDark,
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context: context,
                icon: Icons.calendar_today_outlined,
                label: l10n.graduationYear,
                value: profile.graduationYear?.toString() ?? l10n.notProvided,
                isDark: isDark,
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context: context,
                icon: Icons.workspace_premium_outlined,
                label: l10n.boardCertifications,
                value: profile.boardCertifications ?? l10n.notProvided,
                isDark: isDark,
              ),
              _buildDivider(isDark),
              _buildInfoRow(
                context: context,
                icon: Icons.timer_outlined,
                label: l10n.experience,
                value: '${profile.yearsOfExperience} ${l10n.years}',
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Biography Section (if available)
          if (profile.biography != null && profile.biography!.isNotEmpty) ...[
            _buildSectionHeader(
              context: context,
              title: l10n.biography,
              icon: Icons.description_outlined,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildBiographyCard(context, isDark),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: getBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: FontSize.size16,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size12,
                    color: isDark ? Colors.grey[400] : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: getMediumStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size14,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? Colors.grey[800] : Colors.grey[100],
      indent: 56,
    );
  }

  Widget _buildBiographyCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        profile.biography!,
        style: getRegularStyle(
          fontFamily: FontConstant.cairo,
          fontSize: FontSize.size14,
          color: isDark ? Colors.grey[300] : AppColors.textSecondary,
        ),
      ),
    );
  }
}
