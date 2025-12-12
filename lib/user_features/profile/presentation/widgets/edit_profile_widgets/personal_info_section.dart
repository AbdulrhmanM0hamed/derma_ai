import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../l10n/app_localizations.dart';
import 'edit_profile_section_card.dart';
import 'date_picker_field.dart';
import 'gender_selector.dart';

/// Personal information section widget for edit profile
class PersonalInfoSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController nationalityController;
  final DateTime? selectedDateOfBirth;
  final String? selectedGender;
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<String> onGenderSelected;

  const PersonalInfoSection({
    super.key,
    required this.phoneController,
    required this.nationalityController,
    required this.selectedDateOfBirth,
    required this.selectedGender,
    required this.onDateSelected,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EditProfileSectionCard(
      title: l10n.personalInformation,
      icon: Icons.person_rounded,
      color: Colors.blue,
      animationDelay: const Duration(milliseconds: 100),
      children: [
        CustomTextField(
          controller: phoneController,
          label: l10n.phoneNumber,
          hint: l10n.pleaseEnterPhoneNumber,
          prefixIcon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.pleaseEnterPhoneNumber;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        DatePickerField(
          label: l10n.dateOfBirth,
          hintText: '${l10n.selectDate} (${l10n.optional})',
          selectedDate: selectedDateOfBirth,
          onDateSelected: onDateSelected,
        ),
        const SizedBox(height: 20),

        GenderSelector(
          label: l10n.gender,
          selectedGender: selectedGender,
          maleLabel: l10n.male,
          femaleLabel: l10n.female,
          onGenderSelected: onGenderSelected,
        ),
        const SizedBox(height: 20),

        CustomTextField(
          controller: nationalityController,
          label: l10n.nationality,
          hint: '${l10n.nationality} (${l10n.optional})',
          prefixIcon: Icons.flag_rounded,
        ),
      ],
    );
  }
}
