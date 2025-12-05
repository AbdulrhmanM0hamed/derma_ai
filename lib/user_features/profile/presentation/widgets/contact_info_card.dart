import 'package:derma_ai/user_features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../l10n/app_localizations.dart';

class ContactInfoCard extends StatelessWidget {
  final ProfileState state;

  const ContactInfoCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.contactInformation,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            _buildContactItem(
              icon: Icons.email_outlined,
              label: l10n.email,
              value:
                  state is ProfileSuccess
                      ? (state as ProfileSuccess).userProfile.email
                      : l10n.notAvailable,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),

            _buildContactItem(
              icon: Icons.phone_outlined,
              label: l10n.phoneNumber,
              value:
                  state is ProfileSuccess
                      ? (state as ProfileSuccess).userProfile.phone
                      : l10n.notAvailable,
              color: Colors.green,
            ),
            const SizedBox(height: 12),

            _buildContactItem(
              icon: Icons.location_on_outlined,
              label: l10n.location,
              value:
                  state is ProfileSuccess
                      ? (state as ProfileSuccess).userProfile.location
                      : l10n.notSpecified,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.3);
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 12,
                color: Colors.grey[650],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
