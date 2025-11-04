import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/user_profile_model.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDateOfBirth ??
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Prepare update data
      final Map<String, dynamic> updateData = {
        'phone': _phoneController.text.trim(),
        if (_selectedDateOfBirth != null)
          'date_of_birth': DateFormat(
            'yyyy-MM-dd',
          ).format(_selectedDateOfBirth!),
        if (_selectedGender != null) 'gender': _selectedGender,
        if (_nationalityController.text.trim().isNotEmpty)
          'nationality': _nationalityController.text.trim(),
        if (_emergencyNameController.text.trim().isNotEmpty)
          'emergency_contact_name': _emergencyNameController.text.trim(),
        if (_emergencyPhoneController.text.trim().isNotEmpty)
          'emergency_contact_phone': _emergencyPhoneController.text.trim(),
        if (_emergencyRelationshipController.text.trim().isNotEmpty)
          'emergency_contact_relationship':
              _emergencyRelationshipController.text.trim(),
        if (_selectedLanguage != null) 'language_preference': _selectedLanguage,
      };

      context.read<ProfileCubit>().updateUserProfile(updateData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        print('🟡 [EditProfilePage] State changed to: ${state.runtimeType}');
        
        if (state is ProfileUpdating) {
          print('🟡 [EditProfilePage] ProfileUpdating - Setting loading to true');
          setState(() {
            _isLoading = true;
          });
        } else if (state is ProfileUpdateSuccess) {
          print('🟡 [EditProfilePage] ProfileUpdateSuccess - Phone: ${state.userProfile.phone}');
          setState(() {
            _isLoading = false;
          });
          CustomSnackbar.showSuccess(
            context: context,
            message: l10n.profileUpdatedSuccessfully,
          );
          // Pop immediately so ProfilePage can see the updated state
          print('🟡 [EditProfilePage] Scheduling pop in 300ms...');
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              print('🟡 [EditProfilePage] Popping now!');
              Navigator.pop(context, true);
            }
          });
        } else if (state is ProfileUpdateFailure) {
          print('🔴 [EditProfilePage] ProfileUpdateFailure: ${state.message}');
          setState(() {
            _isLoading = false;
          });
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primary.withValues(alpha: 0.05), Colors.white],
                ),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                // Personal Information Section
                _buildSectionCard(
                  l10n.personalInformation,
                  Icons.person_outline,
                  Colors.blue,
                  [
                    CustomTextField(
                      controller: _phoneController,
                      label: l10n.phoneNumber,
                      hint: l10n.pleaseEnterPhoneNumber,
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterPhoneNumber;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildDateField(l10n),
                    const SizedBox(height: 16),

                    _buildGenderSelector(l10n),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _nationalityController,
                      label: l10n.nationality,
                      hint: '${l10n.nationality} (${l10n.optional})',
                      prefixIcon: Icons.flag_outlined,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Emergency Contact Section
                _buildSectionCard(
                  l10n.emergencyContact,
                  Icons.emergency_outlined,
                  Colors.red,
                  [
                    CustomTextField(
                      controller: _emergencyNameController,
                      label: l10n.emergencyContactName,
                      hint: '${l10n.emergencyContactName} (${l10n.optional})',
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _emergencyPhoneController,
                      label: l10n.emergencyContactPhone,
                      hint: '${l10n.emergencyContactPhone} (${l10n.optional})',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _emergencyRelationshipController,
                      label: l10n.emergencyContactRelationship,
                      hint:
                          '${l10n.emergencyContactRelationship} (${l10n.optional})',
                      prefixIcon: Icons.people_outline,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Preferences Section
                _buildSectionCard(
                  l10n.preferences,
                  Icons.settings_outlined,
                  Colors.purple,
                  [_buildLanguageSelector(l10n)],
                ),

                const SizedBox(height: 32),

                // Save Button
                CustomButton(
                  text: l10n.saveChanges,
                  onPressed: _isLoading ? null : _saveProfile,
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 22,
                  ),
                  height: 56,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 12),

                // Cancel Button
                CustomButton(
                  text: l10n.cancel,
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  backgroundColor: Colors.grey[300],
                  textColor: Colors.grey[700],
                  icon: Icon(Icons.close, color: Colors.grey[700], size: 22),
                  height: 56,
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 20),
                  ],
                ),
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

  Widget _buildSectionCard(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.1),
                  color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: getBoldStyle(
                    fontSize: 18,
                    fontFamily: FontConstant.cairo,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildDateField(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.dateOfBirth,
          style: getSemiBoldStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    _selectedDateOfBirth != null
                        ? AppColors.primary.withValues(alpha: 0.5)
                        : Colors.grey[300]!,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedDateOfBirth != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!)
                        : '${l10n.selectDate} (${l10n.optional})',
                    style: getRegularStyle(
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                      color:
                          _selectedDateOfBirth != null
                              ? Colors.black87
                              : Colors.grey[400],
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.gender,
          style: getSemiBoldStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption(
                value: 'male',
                label: l10n.male,
                icon: Icons.male,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildGenderOption(
                value: 'female',
                label: l10n.female,
                icon: Icons.female,
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
          onTap: () {
            setState(() {
              _selectedGender = value;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color:
                  isSelected ? color.withValues(alpha: 0.15) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? color : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              boxShadow:
                  isSelected
                      ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                      : null,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected ? color : Colors.grey[600],
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: getSemiBoldStyle(
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                    color: isSelected ? color : Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
        .animate(target: isSelected ? 1 : 0)
        .scale(
          duration: 200.ms,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        );
  }

  Widget _buildLanguageSelector(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.languagePreference,
          style: getSemiBoldStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildLanguageOption(
                value: 'ar',
                label: l10n.arabic,
                flag: '🇸🇦',
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildLanguageOption(
                value: 'en',
                label: l10n.english,
                flag: '🇬🇧',
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageOption({
    required String value,
    required String label,
    required String flag,
    required Color color,
  }) {
    final isSelected = _selectedLanguage == value;
    return GestureDetector(
          onTap: () {
            setState(() {
              _selectedLanguage = value;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  isSelected ? color.withValues(alpha: 0.15) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? color : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              boxShadow:
                  isSelected
                      ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                      : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(flag, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label,
                    style: getBoldStyle(
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                      color: isSelected ? color : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(target: isSelected ? 1 : 0)
        .scale(
          duration: 200.ms,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        );
  }
}
