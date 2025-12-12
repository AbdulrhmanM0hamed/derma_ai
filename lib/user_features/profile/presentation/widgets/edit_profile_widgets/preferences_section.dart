import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import 'edit_profile_section_card.dart';
import 'language_selector.dart';

/// Preferences section widget for edit profile
class PreferencesSection extends StatelessWidget {
  final String? selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const PreferencesSection({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EditProfileSectionCard(
      title: l10n.preferences,
      icon: Icons.tune_rounded,
      color: Colors.purple,
      animationDelay: const Duration(milliseconds: 300),
      children: [
        LanguageSelector(
          label: l10n.languagePreference,
          selectedLanguage: selectedLanguage,
          arabicLabel: l10n.arabic,
          englishLabel: l10n.english,
          onLanguageSelected: onLanguageSelected,
        ),
      ],
    );
  }
}
