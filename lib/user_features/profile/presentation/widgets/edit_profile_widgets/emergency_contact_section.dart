import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../l10n/app_localizations.dart';
import 'edit_profile_section_card.dart';

/// Emergency contact section widget for edit profile
class EmergencyContactSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController relationshipController;

  const EmergencyContactSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.relationshipController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EditProfileSectionCard(
      title: l10n.emergencyContact,
      icon: Icons.emergency_rounded,
      color: Colors.red,
      animationDelay: const Duration(milliseconds: 200),
      children: [
        CustomTextField(
          controller: nameController,
          label: l10n.emergencyContactName,
          hint: '${l10n.emergencyContactName} (${l10n.optional})',
          prefixIcon: Icons.person_rounded,
        ),
        const SizedBox(height: 20),

        CustomTextField(
          controller: phoneController,
          label: l10n.emergencyContactPhone,
          hint: '${l10n.emergencyContactPhone} (${l10n.optional})',
          prefixIcon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),

        CustomTextField(
          controller: relationshipController,
          label: l10n.emergencyContactRelationship,
          hint: '${l10n.emergencyContactRelationship} (${l10n.optional})',
          prefixIcon: Icons.people_rounded,
        ),
      ],
    );
  }
}
