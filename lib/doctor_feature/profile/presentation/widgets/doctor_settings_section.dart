import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/widgets/doctor_logout_confirmation_dialog.dart';
import '../../../../l10n/app_localizations.dart';

class DoctorSettingsSection extends StatelessWidget {
  const DoctorSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            context: context,
            title: l10n.accountSettings,
            icon: Icons.settings_outlined,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          Container(
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
            child: Column(
              children: [
                _buildSettingItem(
                  context: context,
                  icon: Icons.notifications_outlined,
                  title: l10n.notifications,
                  iconColor: const Color(0xFF6C5CE7),
                  isDark: isDark,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Navigate to notifications settings
                  },
                ),
                _buildDivider(isDark),
                _buildSettingItem(
                  context: context,
                  icon: Icons.lock_outline_rounded,
                  title: l10n.privacySecurity,
                  iconColor: const Color(0xFF00B894),
                  isDark: isDark,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Navigate to privacy settings
                  },
                ),
                _buildDivider(isDark),
                _buildSettingItem(
                  context: context,
                  icon: Icons.language_outlined,
                  title: l10n.language,
                  iconColor: const Color(0xFF0984E3),
                  isDark: isDark,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Navigate to language settings
                  },
                ),
                _buildDivider(isDark),
                _buildSettingItem(
                  context: context,
                  icon: Icons.help_outline_rounded,
                  title: l10n.helpSupport,
                  iconColor: const Color(0xFFFDAA5E),
                  isDark: isDark,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Navigate to help & support
                  },
                ),
                _buildDivider(isDark),
                _buildSettingItem(
                  context: context,
                  icon: Icons.logout_rounded,
                  title: l10n.logout,
                  iconColor: Colors.red,
                  isDark: isDark,
                  isDestructive: true,
                  showArrow: false,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    DoctorLogoutConfirmationDialog.show(context);
                  },
                ),
              ],
            ),
          ),
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

  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color iconColor,
    required bool isDark,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool showArrow = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: getMediumStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size14,
                    color: isDestructive
                        ? Colors.red
                        : (isDark ? Colors.white : AppColors.textPrimary),
                  ),
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? Colors.grey[800] : Colors.grey[100],
      indent: 60,
    );
  }
}
