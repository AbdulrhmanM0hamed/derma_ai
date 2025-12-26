import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/service_locatores.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../bloc/profile_cubit.dart';
import '../../bloc/profile_state.dart';
import '../../pages/edit_profile_page.dart';
import 'settings_section_card.dart';
import 'settings_item_tile.dart';

/// Account settings section widget
class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsSectionCard(
      title: l10n.accountSection,
      icon: Icons.person_rounded,
      animationDelay: const Duration(milliseconds: 100),
      children: [
        SettingsItemTile(
          icon: Icons.edit_rounded,
          title: l10n.editProfile,
          subtitle: l10n.editProfileSubtitle,
          onTap: () => _navigateToEditProfile(context),
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.lock_rounded,
          title: l10n.changePassword,
          subtitle: l10n.changePasswordSubtitle,
          onTap: () {
            // TODO: Navigate to change password
          },
          showArrow: true,
        ),
        SettingsItemTile(
          icon: Icons.email_rounded,
          title: l10n.changeEmail,
          subtitle: l10n.changeEmailSubtitle,
          onTap: () {
            // TODO: Navigate to change email
          },
          showArrow: true,
        ),
      ],
    );
  }

  Future<void> _navigateToEditProfile(BuildContext context) async {
    final profileCubit = sl<ProfileCubit>();

    if (profileCubit.state is! ProfileSuccess) {
      await profileCubit.getUserProfile();
    }

    if (profileCubit.state is ProfileSuccess && context.mounted) {
      final state = profileCubit.state as ProfileSuccess;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: profileCubit,
            child: EditProfilePage(userProfile: state.userProfile),
          ),
        ),
      );
    }
  }
}
