import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.appName,
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontFamily: FontConstant.cairo,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.appTagline,
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            fontFamily: FontConstant.cairo,
          ),
        ),
      ],
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 300.ms,
      beginY: 0.2,
    ));
  }
}
