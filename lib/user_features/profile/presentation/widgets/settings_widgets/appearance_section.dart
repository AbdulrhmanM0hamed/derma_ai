import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/locale/locale_cubit.dart';
import '../../../../../core/cubit/theme/theme_cubit.dart';
import '../../../../../l10n/app_localizations.dart';
import 'settings_section_card.dart';
import 'settings_item_tile.dart';
import 'settings_dropdown_tile.dart';

/// Appearance settings section widget
class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsSectionCard(
      title: l10n.appearanceSection,
      icon: Icons.palette_rounded,
      animationDelay: const Duration(milliseconds: 300),
      children: [
        // Language selector
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return SettingsDropdownTile(
              icon: Icons.translate_rounded,
              title: l10n.language,
              subtitle: l10n.languageSubtitle,
              value: state.locale.languageCode == 'ar'
                  ? l10n.arabic
                  : l10n.english,
              items: [l10n.arabic, l10n.english],
              onChanged: (value) {
                final newLocale = value == l10n.arabic
                    ? const Locale('ar')
                    : const Locale('en');
                context.read<LocaleCubit>().changeLocale(newLocale);
              },
            );
          },
        ),
        // Theme selector
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            String getThemeName(ThemeMode mode) {
              switch (mode) {
                case ThemeMode.light:
                  return l10n.themeLight;
                case ThemeMode.dark:
                  return l10n.themeDark;
                case ThemeMode.system:
                  return l10n.themeSystem;
              }
            }

            return SettingsDropdownTile(
              icon: Icons.dark_mode_rounded,
              title: l10n.theme,
              subtitle: l10n.themeSubtitle,
              value: getThemeName(state.themeMode),
              items: [l10n.themeLight, l10n.themeDark, l10n.themeSystem],
              onChanged: (value) {
                ThemeMode newMode;
                if (value == l10n.themeLight) {
                  newMode = ThemeMode.light;
                } else if (value == l10n.themeDark) {
                  newMode = ThemeMode.dark;
                } else {
                  newMode = ThemeMode.system;
                }
                context.read<ThemeCubit>().changeTheme(newMode);
              },
            );
          },
        ),
        SettingsItemTile(
          icon: Icons.text_fields_rounded,
          title: l10n.fontSize,
          subtitle: l10n.fontSizeSubtitle,
          onTap: () {
            // TODO: Navigate to font size settings
          },
          showArrow: true,
        ),
      ],
    );
  }
}
