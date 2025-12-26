import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/user_profile_model.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import '../widgets/edit_profile_widgets/edit_profile_widgets.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfileModel userProfile;

  const EditProfilePage({super.key, required this.userProfile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  late TextEditingController _nationalityController;
  late TextEditingController _emergencyNameController;
  late TextEditingController _emergencyPhoneController;
  late TextEditingController _emergencyRelationshipController;

  DateTime? _selectedDateOfBirth;
  String? _selectedGender;
  String? _selectedLanguage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.userProfile.phone);
    _nationalityController = TextEditingController(
      text: widget.userProfile.nationality ?? '',
    );
    _emergencyNameController = TextEditingController(
      text: widget.userProfile.emergencyContactName ?? '',
    );
    _emergencyPhoneController = TextEditingController(
      text: widget.userProfile.emergencyContactPhone ?? '',
    );
    _emergencyRelationshipController = TextEditingController(
      text: widget.userProfile.emergencyContactRelationship ?? '',
    );
    _selectedDateOfBirth = widget.userProfile.dateOfBirth;
    _selectedGender = widget.userProfile.gender;
    _selectedLanguage = widget.userProfile.languagePreference;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nationalityController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationshipController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> updateData = {
        'phone': _phoneController.text.trim(),
        if (_selectedDateOfBirth != null)
          'date_of_birth': DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!),
        if (_selectedGender != null) 'gender': _selectedGender,
        if (_nationalityController.text.trim().isNotEmpty)
          'nationality': _nationalityController.text.trim(),
        if (_emergencyNameController.text.trim().isNotEmpty)
          'emergency_contact_name': _emergencyNameController.text.trim(),
        if (_emergencyPhoneController.text.trim().isNotEmpty)
          'emergency_contact_phone': _emergencyPhoneController.text.trim(),
        if (_emergencyRelationshipController.text.trim().isNotEmpty)
          'emergency_contact_relationship': _emergencyRelationshipController.text.trim(),
        if (_selectedLanguage != null) 'language_preference': _selectedLanguage,
      };

      context.read<ProfileCubit>().updateUserProfile(updateData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdating) {
          setState(() => _isLoading = true);
        } else if (state is ProfileUpdateSuccess) {
          setState(() => _isLoading = false);
          CustomSnackbar.showSuccess(
            context: context,
            message: l10n.profileUpdatedSuccessfully,
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) Navigator.pop(context, true);
          });
        } else if (state is ProfileUpdateFailure) {
          setState(() => _isLoading = false);
          CustomSnackbar.showError(
            context: context,
            message: l10n.profileUpdateFailed,
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: l10n.editProfile),
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          AppColors.primary.withValues(alpha: 0.1),
                          Theme.of(context).scaffoldBackgroundColor,
                        ]
                      : [
                          AppColors.primary.withValues(alpha: 0.05),
                          Colors.white,
                        ],
                ),
              ),
            ),
            // Form content
            Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Personal Information Section
                  PersonalInfoSection(
                    phoneController: _phoneController,
                    nationalityController: _nationalityController,
                    selectedDateOfBirth: _selectedDateOfBirth,
                    selectedGender: _selectedGender,
                    onDateSelected: (date) {
                      setState(() => _selectedDateOfBirth = date);
                    },
                    onGenderSelected: (gender) {
                      setState(() => _selectedGender = gender);
                    },
                  ),

                  const SizedBox(height: 20),

                  // Emergency Contact Section
                  EmergencyContactSection(
                    nameController: _emergencyNameController,
                    phoneController: _emergencyPhoneController,
                    relationshipController: _emergencyRelationshipController,
                  ),

                  const SizedBox(height: 20),

                  // Preferences Section
                  PreferencesSection(
                    selectedLanguage: _selectedLanguage,
                    onLanguageSelected: (language) {
                      setState(() => _selectedLanguage = language);
                    },
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  EditProfileActions(
                    isLoading: _isLoading,
                    onSave: _saveProfile,
                    onCancel: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Loading Overlay
            if (_isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: const CustomProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
