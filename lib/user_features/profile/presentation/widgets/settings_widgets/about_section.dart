import 'package:flutter/material.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import 'settings_section_card.dart';
import 'settings_item_tile.dart';

/// About settings section widget with logout
class AboutSection extends StatelessWidget {
  final VoidCallback onLogout;

  const AboutSection({
    super.key,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SettingsSectionCard(
      title: l10n.aboutSection,
      icon: Icons.info_rounded,
      animationDelay: const Duration(milliseconds: 500),
      children: [
        SettingsItemTile(
          icon: Icons.info_outline_rounded,
          title: l10n.appInfo,
          subtitle: l10n.appVersion,
          onTap: () {
            _showAppInfoDialog(context, l10n);
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.system_update_rounded,
          title: l10n.updatesTitle,
          subtitle: l10n.updatesSubtitle,
          onTap: () {
            // TODO: Check for updates
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.logout_rounded,
          title: l10n.logout,
          subtitle: l10n.logoutDialogMessage,
          titleColor: isDark ? Colors.red[300] : Colors.red,
          iconColor: isDark ? Colors.red[300] : Colors.red,
          onTap: onLogout,
          showArrow: false,
        ),
      ],
    );
  }

  void _showAppInfoDialog(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.medical_services_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Derma AI',
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              'الإصدار',
              '1.0.0',
              Icons.tag_rounded,
              isDark,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'تاريخ الإصدار',
              '2024',
              Icons.calendar_today_rounded,
              isDark,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'المطور',
              'Derma AI Team',
              Icons.code_rounded,
              isDark,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
