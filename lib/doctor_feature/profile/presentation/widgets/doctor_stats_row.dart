import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/doctor_profile_model.dart';

class DoctorStatsRow extends StatelessWidget {
  final DoctorProfileModel profile;

  const DoctorStatsRow({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildStatCard(
            context: context,
            icon: Icons.people_alt_outlined,
            value: '0', // Static for now
            label: l10n.patients,
            color: const Color.fromARGB(255, 97, 77, 253),
            isDark: isDark,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            context: context,
            icon: Icons.calendar_month_outlined,
            value: profile.totalConsultations.toString(),
            label: l10n.consultations,
            color: const Color(0xFF00B894),
            isDark: isDark,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            context: context,
            icon: Icons.workspace_premium_outlined,
            value: '${profile.yearsOfExperience}',
            label: l10n.yearsExp,
            color: const Color(0xFFFDAA5E),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            // BoxShadow(
            //   color: color.withValues(alpha: 0.15),
            //   blurRadius: 3,
            //   offset: const Offset(0, 5),
            // ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size20,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size11,
                color: isDark ? Colors.grey[400] : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
