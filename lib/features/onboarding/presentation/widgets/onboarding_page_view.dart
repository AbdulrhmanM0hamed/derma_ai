import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Spacer(flex: 2),
            // Image container with professional design
            Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.white.withValues(alpha: 0.95),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                    spreadRadius: -5,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Stack(
                  children: [
                    // Subtle background pattern
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.03),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.02),
                        ),
                      ),
                    ),
                    // Main image
                    Center(
                      child: SvgPicture.asset(
                        item.image,
                        height: 280,
                        width: 280,
                        fit: BoxFit.contain,
),
                    ),
                  ],
                ),
              ),
),
            const Spacer(flex: 1),
            // Title with enhanced typography
            Text(
              item.title,
              style: getBoldStyle(
                fontSize: 32,
                color: AppColors.textPrimary,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
),
            const SizedBox(height: 24),
            // Description with better spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                item.description,
                style: getRegularStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  fontFamily: FontConstant.cairo,
                
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
