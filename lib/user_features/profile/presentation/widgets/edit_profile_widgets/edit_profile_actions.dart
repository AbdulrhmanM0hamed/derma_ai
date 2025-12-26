import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../l10n/app_localizations.dart';

/// Action buttons for edit profile page
class EditProfileActions extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const EditProfileActions({
    super.key,
    required this.isLoading,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Save Button
        CustomButton(
          text: l10n.saveChanges,
          onPressed: isLoading ? null : onSave,
          icon: const Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
            size: 22,
          ),
          height: 56,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

        const SizedBox(height: 12),

        // Cancel Button
        CustomButton(
          text: l10n.cancel,
          onPressed: isLoading ? null : onCancel,
          backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
          textColor: isDark ? Colors.grey[300] : Colors.grey[700],
          icon: Icon(
            Icons.close_rounded,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
            size: 22,
          ),
          height: 56,
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
      ],
    );
  }
}
