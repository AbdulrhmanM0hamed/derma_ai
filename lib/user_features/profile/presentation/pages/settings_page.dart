import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubit/locale/locale_cubit.dart';
import '../../../../core/cubit/theme/theme_cubit.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import 'edit_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(l10n),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAccountSection(l10n),
            const SizedBox(height: 16),
            _buildSecuritySection(l10n),
            const SizedBox(height: 16),
            _buildAppearanceSection(l10n),
            const SizedBox(height: 16),
            _buildSupportSection(l10n),
            const SizedBox(height: 16),
            _buildAboutSection(l10n),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(AppLocalizations l10n) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        l10n.settingsTitle,
        style: getBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildAccountSection(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.accountSection,
      icon: Icons.person_outline,
      children: [
        _buildSettingItem(
          icon: Icons.edit_outlined,
          title: l10n.editProfile,
          subtitle: l10n.editProfileSubtitle,
          onTap: () async {
            // Get ProfileCubit and fetch user data
            final profileCubit = sl<ProfileCubit>();

            // Fetch profile if not already loaded
            if (profileCubit.state is! ProfileSuccess) {
              await profileCubit.getUserProfile();
            }

            // Navigate only if we have valid data
            if (profileCubit.state is ProfileSuccess && mounted) {
              final state = profileCubit.state as ProfileSuccess;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider.value(
                        value: profileCubit,
                        child: EditProfilePage(userProfile: state.userProfile),
                      ),
                ),
              );
            }
          },
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.lock_outline,
          title: l10n.changePassword,
          subtitle: l10n.changePasswordSubtitle,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.email_outlined,
          title: l10n.changeEmail,
          subtitle: l10n.changeEmailSubtitle,
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildSecuritySection(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.securitySection,
      icon: Icons.security_outlined,
      children: [
        _buildSwitchItem(
          icon: Icons.fingerprint_outlined,
          title: l10n.biometricAuth,
          subtitle: l10n.biometricAuthSubtitle,
          value: _biometricEnabled,
          onChanged: (value) {
            setState(() {
              _biometricEnabled = value;
            });
          },
        ),
        _buildSwitchItem(
          icon: Icons.location_on_outlined,
          title: l10n.locationServices,
          subtitle: l10n.locationServicesSubtitle,
          value: _locationEnabled,
          onChanged: (value) {
            setState(() {
              _locationEnabled = value;
            });
          },
        ),
        _buildSettingItem(
          icon: Icons.privacy_tip_outlined,
          title: l10n.privacyPolicy,
          subtitle: l10n.privacyPolicySubtitle,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.description_outlined,
          title: l10n.termsOfUse,
          subtitle: l10n.termsOfUseSubtitle,
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3);
  }

  Widget _buildAppearanceSection(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.appearanceSection,
      icon: Icons.palette_outlined,
      children: [
        // Language selector with LocaleCubit
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return _buildDropdownItem(
              icon: Icons.language_outlined,
              title: l10n.language,
              subtitle: l10n.languageSubtitle,
              value:
                  state.locale.languageCode == 'ar'
                      ? l10n.arabic
                      : l10n.english,
              items: [l10n.arabic, l10n.english],
              onChanged: (value) {
                final newLocale =
                    value == l10n.arabic
                        ? const Locale('ar')
                        : const Locale('en');
                context.read<LocaleCubit>().changeLocale(newLocale);
              },
            );
          },
        ),
        // Theme selector with ThemeCubit
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

            return _buildDropdownItem(
              icon: Icons.brightness_6_outlined,
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
        _buildSettingItem(
          icon: Icons.text_fields_outlined,
          title: l10n.fontSize,
          subtitle: l10n.fontSizeSubtitle,
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildSupportSection(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.supportSection,
      icon: Icons.help_outline,
      children: [
        _buildSettingItem(
          icon: Icons.help_center_outlined,
          title: l10n.helpCenter,
          subtitle: l10n.helpCenterSubtitle,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.contact_support_outlined,
          title: l10n.contactUs,
          subtitle: l10n.contactUsSubtitle,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.bug_report_outlined,
          title: l10n.reportProblem,
          subtitle: l10n.reportProblemSubtitle,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.star_outline,
          title: l10n.rateApp,
          subtitle: l10n.rateAppSubtitle,
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildAboutSection(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.aboutSection,
      icon: Icons.info_outline,
      children: [
        _buildSettingItem(
          icon: Icons.info_outlined,
          title: l10n.appInfo,
          subtitle: l10n.appVersion,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.update_outlined,
          title: l10n.updatesTitle,
          subtitle: l10n.updatesSubtitle,
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.logout,
          title: l10n.logout,
          subtitle: l10n.logoutDialogMessage,
          onTap: () => _showLogoutDialog(l10n),
          showArrow: false,
          titleColor: Colors.red,
          iconColor: Colors.red,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.3);
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showArrow = false,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 0.5)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? Colors.grey[600])!.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor ?? Colors.grey[600], size: 20),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: titleColor ?? Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing:
            showArrow
                ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                )
                : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 0.5)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[600]!.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.grey[600], size: 20),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 0.5)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[600]!.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.grey[600], size: 20),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _showLogoutDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            l10n.logoutDialogTitle,
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          content: Text(
            l10n.logoutDialogMessage,
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.cancel,
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle logout logic here
              },
              child: Text(
                l10n.logout,
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
