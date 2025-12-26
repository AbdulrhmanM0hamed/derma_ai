import 'package:flutter/material.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../l10n/app_localizations.dart';

class ProfileErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ProfileErrorBanner({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dataLoadError,
                  style: getBoldStyle(
                    color: Colors.red.shade700,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: getRegularStyle(
                    color: Colors.red.shade600,
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(
              l10n.retryButton,
              style: getBoldStyle(
                color: Colors.red.shade700,
                fontSize: 12,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
