import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../domain/models/onboarding_item.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController pageController;
  final List<OnboardingItem> onboardingItems;
  final Function(int) onPageChanged;

  const OnboardingPageView({
    super.key,
    required this.pageController,
    required this.onboardingItems,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: onboardingItems.length,
      reverse: true, // RTL scrolling for Arabic app
      itemBuilder: (context, index) {
        return _buildOnboardingPage(onboardingItems[index]);
      },
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          SvgPicture.asset(
            item.image,
            height: 300,
            fit: BoxFit.contain,
          )
              .animate()
              .fadeIn(duration: 900.ms, delay: 300.ms)
              .slideY(begin: 0.2, duration: 700.ms, curve: Curves.easeOut),
          const Spacer(flex: 2),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: getBoldStyle(
              fontSize: 26,
              fontFamily: FontConstant.cairo,
            ),
          )
              .animate()
              .fadeIn(duration: 900.ms, delay: 500.ms)
              .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut),
          const SizedBox(height: 16),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: getRegularStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontFamily: FontConstant.cairo,
              height: 1.5,
            ),
          )
              .animate()
              .fadeIn(duration: 900.ms, delay: 700.ms)
              .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
