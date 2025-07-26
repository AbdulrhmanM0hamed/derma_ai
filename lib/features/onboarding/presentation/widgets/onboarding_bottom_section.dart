import 'package:flutter/material.dart';

import 'package:derma_ai/core/utils/theme/app_colors.dart';



import 'onboarding_dot_indicator.dart';

class OnboardingBottomSection extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final PageController? pageController;

  const OnboardingBottomSection({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    this.onPrevious,
    this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final isFirstPage = currentPage == 0;
    final isLastPage = currentPage == totalPages - 1;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
        vertical: isSmallScreen ? 16 : 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dot indicators (RTL Order)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 4 : 6,
                ),
                child: OnboardingDotIndicator(
                  isActive: index == (totalPages - 1 - currentPage), // Reversed logic for RTL
                  index: index,
                ),
              ),
            ), // RTL visual order
          ),
          SizedBox(height: isSmallScreen ? 32 : 40),
          // Navigation controls (Reversed positions)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Next/Get Started button (left side)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.8,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    )),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: isLastPage
                    ? _buildGetStartedButton(isSmallScreen: isSmallScreen)
                    : _buildNavigationButton(
                        key: const ValueKey('next'),
                        icon: Icons.arrow_back_ios,
                        onPressed: onNext,
                        isEnabled: true,
                        isPrimary: true,
                        isSmallScreen: isSmallScreen,
                      ),
              ),
              // Previous button (right side)
              _buildNavigationButton(
                icon: Icons.arrow_forward_ios,
                onPressed: isFirstPage ? null : onPrevious,
                isEnabled: !isFirstPage,
                isSmallScreen: isSmallScreen,
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildGetStartedButton({bool isSmallScreen = false}) {
    final buttonWidth = isSmallScreen ? 100.0 : 120.0;
    final buttonHeight = isSmallScreen ? 56.0 : 64.0;
    
    return Container(
      key: const ValueKey('getStarted'),
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(buttonHeight / 2),
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 25,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
            spreadRadius: -2,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onNext,
          borderRadius: BorderRadius.circular(32),
          splashColor: Colors.white.withValues(alpha: 0.3),
          highlightColor: Colors.white.withValues(alpha: 0.1),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'ابدأ الآن',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isEnabled,
    bool isPrimary = false,
    bool isSmallScreen = false,
  }) {
    final buttonSize = isSmallScreen ? 56.0 : 64.0;
    
    return AnimatedContainer(
      key: key,
      duration: const Duration(milliseconds: 300),
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isPrimary && isEnabled
            ? LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isPrimary
            ? null
            : isEnabled
                ? Colors.white
                : Colors.grey.withValues(alpha: 0.1),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: isPrimary
                      ? AppColors.primary.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.15),
                  blurRadius: isPrimary ? 25 : 15,
                  offset: Offset(0, isPrimary ? 10 : 6),
                  spreadRadius: isPrimary ? 2 : 0,
                ),
                if (isPrimary)
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                    spreadRadius: -2,
                  ),
              ]
            : null,
        border: !isPrimary && isEnabled
            ? Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          splashColor: isPrimary
              ? Colors.white.withValues(alpha: 0.3)
              : AppColors.primary.withValues(alpha: 0.1),
          highlightColor: isPrimary
              ? Colors.white.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.05),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isPrimary
                  ? Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    )
                  : null,
            ),
            child: Center(
              child: Icon(
                icon,
                color: isPrimary
                    ? Colors.white
                    : isEnabled
                        ? AppColors.primary
                        : Colors.grey,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


