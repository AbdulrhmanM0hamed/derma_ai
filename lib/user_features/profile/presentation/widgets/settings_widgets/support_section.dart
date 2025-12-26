import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import 'settings_section_card.dart';
import 'settings_item_tile.dart';

/// Support settings section widget
class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsSectionCard(
      title: l10n.supportSection,
      icon: Icons.support_agent_rounded,
      animationDelay: const Duration(milliseconds: 400),
      children: [
        SettingsItemTile(
          icon: Icons.help_center_rounded,
          title: l10n.helpCenter,
          subtitle: l10n.helpCenterSubtitle,
          onTap: () {
            // TODO: Navigate to help center
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.chat_bubble_rounded,
          title: l10n.contactUs,
          subtitle: l10n.contactUsSubtitle,
          onTap: () {
            // TODO: Navigate to contact us
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.bug_report_rounded,
          title: l10n.reportProblem,
          subtitle: l10n.reportProblemSubtitle,
          onTap: () {
            // TODO: Navigate to report problem
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.star_rounded,
          title: l10n.rateApp,
          subtitle: l10n.rateAppSubtitle,
          iconColor: Colors.amber,
          onTap: () {
            // TODO: Open app store for rating
          },
          showArrow: true,
        ),
      ],
    );
  }
}
