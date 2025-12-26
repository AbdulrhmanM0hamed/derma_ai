import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../core/widgets/logout_confirmation_dialog.dart';
import '../../../../../l10n/app_localizations.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          LogoutConfirmationDialog.show(context);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: BorderSide(
            color: Colors.red.withValues(alpha: isDark ? 0.7 : 1.0),
            width: 1.5,
          ),
          backgroundColor: isDark
              ? Colors.red.withValues(alpha: 0.1)
              : Colors.red.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              size: 20,
              color: isDark ? Colors.red[300] : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.logout,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: isDark ? Colors.red[300] : Colors.red,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.5);
  }
}
