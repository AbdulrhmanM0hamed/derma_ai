import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/settings_widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _biometricEnabled = false;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.settingsTitle,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const AccountSection(),
            const SizedBox(height: 16),
            SecuritySection(
              biometricEnabled: _biometricEnabled,
              locationEnabled: _locationEnabled,
              onBiometricChanged: (value) {
                setState(() => _biometricEnabled = value);
              },
              onLocationChanged: (value) {
                setState(() => _locationEnabled = value);
              },
            ),
            const SizedBox(height: 16),
            const AppearanceSection(),
            const SizedBox(height: 16),
            const SupportSection(),
            const SizedBox(height: 16),
            AboutSection(
              onLogout: () => _showLogoutDialog(context),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final result = await LogoutDialog.show(context);
    if (result == true && mounted) {
      // Handle logout logic here
    }
  }
}
