import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helpers/image_picker_helper.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/profile_error_banner.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_logout_button.dart';
import '../widgets/profile_menu_items.dart';
import '../widgets/recent_appointments_card.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = sl<ProfileCubit>();

    // Only fetch if we don't have data yet
    if (_profileCubit.state is! ProfileSuccess) {
      _profileCubit.getUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // Listener for state changes - UI rebuilds automatically
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await _profileCubit.refreshProfile();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Error banner
                      if (state is ProfileFailure)
                        ProfileErrorBanner(
                          message: state.message,
                          onRetry:
                              () =>
                                  context.read<ProfileCubit>().getUserProfile(),
                        ),

                      // Header with avatar and stats
                      ProfileHeader(
                        state: state,
                        onEditProfileTap:
                            () => _navigateToEditProfile(context, state),
                        onProfilePictureTap:
                            () => _showProfilePictureOptions(
                              context,
                              state is ProfileSuccess
                                  ? state.userProfile.profilePictureUrl
                                  : null,
                            ),
                      ),

                      // Contact information
                      ContactInfoCard(state: state),

                      // Recent appointments
                      const RecentAppointmentsCard(),

                      // Menu items
                      const ProfileMenuItems(),

                      // Logout button
                      const ProfileLogoutButton(),

                      const SizedBox(height: 20), // Space for bottom navigation
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context, ProfileState state) async {
    if (state is! ProfileSuccess) return;

    final cubit = context.read<ProfileCubit>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider.value(
              value: cubit,
              child: EditProfilePage(userProfile: state.userProfile),
            ),
      ),
    );
  }

  void _showProfilePictureOptions(
    BuildContext context,
    String? currentPictureUrl,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (bottomSheetContext) => BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _profileCubit,
            builder: (context, state) {
              final pictureUrl =
                  state is ProfileSuccess
                      ? state.userProfile.profilePictureUrl
                      : null;

              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.changeProfilePicture,
                      style: getBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Upload from gallery
                    _buildBottomSheetOption(
                      icon: Icons.photo_library,
                      label: l10n.gallery,
                      color: const Color(0xFF1295CC),
                      onTap: () {
                        Navigator.pop(bottomSheetContext);
                        _uploadPictureFromGallery();
                      },
                    ),

                    // Upload from camera
                    _buildBottomSheetOption(
                      icon: Icons.camera_alt,
                      label: l10n.camera,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.pop(bottomSheetContext);
                        _uploadPictureFromCamera();
                      },
                    ),

                    // Delete picture (only if picture exists)
                    if (pictureUrl != null)
                      _buildBottomSheetOption(
                        icon: Icons.delete,
                        label: l10n.deletePicture,
                        color: Colors.red,
                        onTap: () {
                          Navigator.pop(bottomSheetContext);
                          _confirmDeletePicture();
                        },
                      ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        label,
        style: getSemiBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 14,
          color: color == Colors.red ? Colors.red : null,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _uploadPictureFromGallery() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final file = await ImagePickerHelper.pickImageFromGallery();
      if (file != null) {
        final currentState = _profileCubit.state;
        if (currentState is ProfileSuccess &&
            currentState.userProfile.profilePictureUrl != null) {
          await CachedNetworkImage.evictFromCache(
            currentState.userProfile.profilePictureUrl!,
          );
        }

        await _profileCubit.uploadProfilePicture(file.path);
        if (mounted) {
          CustomSnackbar.showSuccess(
            context: context,
            message: l10n.pictureUploadedSuccessfully,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(context: context, message: e.toString());
      }
    }
  }

  Future<void> _uploadPictureFromCamera() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final file = await ImagePickerHelper.pickImageFromCamera();
      if (file != null) {
        final currentState = _profileCubit.state;
        if (currentState is ProfileSuccess &&
            currentState.userProfile.profilePictureUrl != null) {
          await CachedNetworkImage.evictFromCache(
            currentState.userProfile.profilePictureUrl!,
          );
        }

        await _profileCubit.uploadProfilePicture(file.path);
        if (mounted) {
          CustomSnackbar.showSuccess(
            context: context,
            message: l10n.pictureUploadedSuccessfully,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(context: context, message: e.toString());
      }
    }
  }

  void _confirmDeletePicture() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              l10n.deletePicture,
              style: getBoldStyle(fontFamily: FontConstant.cairo, fontSize: 18),
            ),
            content: Text(
              l10n.confirmDeletePicture,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
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
                onPressed: () async {
                  Navigator.pop(context);
                  await _deletePicture();
                },
                child: Text(
                  l10n.delete,
                  style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _deletePicture() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileCubit.deleteProfilePicture();
      if (mounted) {
        CustomSnackbar.showSuccess(
          context: context,
          message: l10n.pictureDeletedSuccessfully,
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(
          context: context,
          message: l10n.pictureDeleteFailed,
        );
      }
    }
  }
}
