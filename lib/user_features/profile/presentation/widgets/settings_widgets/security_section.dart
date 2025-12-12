import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import 'settings_section_card.dart';
import 'settings_item_tile.dart';
import 'settings_switch_tile.dart';

/// Security settings section widget
class SecuritySection extends StatelessWidget {
  final bool biometricEnabled;
  final bool locationEnabled;
  final ValueChanged<bool> onBiometricChanged;
  final ValueChanged<bool> onLocationChanged;

  const SecuritySection({
    super.key,
    required this.biometricEnabled,
    required this.locationEnabled,
    required this.onBiometricChanged,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsSectionCard(
      title: l10n.securitySection,
      icon: Icons.shield_rounded,
      animationDelay: const Duration(milliseconds: 200),
      children: [
        SettingsSwitchTile(
          icon: Icons.fingerprint_rounded,
          title: l10n.biometricAuth,
          subtitle: l10n.biometricAuthSubtitle,
          value: biometricEnabled,
          onChanged: onBiometricChanged,
        ),
        SettingsSwitchTile(
          icon: Icons.location_on_rounded,
          title: l10n.locationServices,
          subtitle: l10n.locationServicesSubtitle,
          value: locationEnabled,
          onChanged: onLocationChanged,
        ),
        SettingsItemTile(
          icon: Icons.privacy_tip_rounded,
          title: l10n.privacyPolicy,
          subtitle: l10n.privacyPolicySubtitle,
          onTap: () {
            // TODO: Navigate to privacy policy
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.description_rounded,
          title: l10n.termsOfUse,
          subtitle: l10n.termsOfUseSubtitle,
          onTap: () {
            // TODO: Navigate to terms of use
          },
          showArrow: true,
        ),
      ],
    );
  }
}
