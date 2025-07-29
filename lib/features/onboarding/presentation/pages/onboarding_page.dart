import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../widgets/onboarding_skip_button.dart';
import '../widgets/onboarding_bottom_section.dart';
import '../../domain/models/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: 'assets/images/onboarding1.svg',
      title: 'تحليل البشرة بالذكاء الاصطناعي',
      description:
          'احصل على تحليل فوري لحالة بشرتك باستخدام تقنيات الذكاء الاصطناعي المتقدمة',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.svg',
      title: 'استشارة أطباء الجلد المعتمدين',
      description: 'تواصل مع أطباء جلدية متخصصين للحصول على نصائح طبية موثوقة',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.svg',
      title: 'خطط علاجية مخصصة لبشرتك',
      description: 'استلم توصيات علاجية مخصصة تناسب نوع بشرتك وحالتها',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final imageSize =
        isSmallScreen ? screenSize.width * 0.65 : screenSize.width * 0.78;
    final titleFontSize = isSmallScreen ? 22.0 : 24.0;
    final descriptionFontSize = isSmallScreen ? 14.0 : 16.0;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.08,
            ),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.14),
                // Animated Image container with professional design
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  height: imageSize,
                  width: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(imageSize * 0.12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        AppColors.primary.withValues(alpha: 0.06),
                        Colors.white.withValues(alpha: 0.98),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        blurRadius: imageSize * 0.12,
                        offset: Offset(0, imageSize * 0.06),
                        spreadRadius: -imageSize * 0.02,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: imageSize * 0.06,
                        offset: Offset(0, imageSize * 0.03),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(imageSize * 0.12),
                    child: Stack(
                      children: [
                        // Animated background patterns
                        Positioned(
                          top: -imageSize * 0.15,
                          right: -imageSize * 0.15,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 800),
                            width: imageSize * 0.4,
                            height: imageSize * 0.4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.025),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -imageSize * 0.08,
                          left: -imageSize * 0.08,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: imageSize * 0.25,
                            height: imageSize * 0.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.015),
                            ),
                          ),
                        ),
                        // Main image with hero animation
                        Center(
                          child: Hero(
                            tag: 'onboarding_image_${item.image}',
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 500),
                              scale: 1.0,
                              child: SvgPicture.asset(
                                item.image,
                                height: imageSize * 0.7,
                                width: imageSize * 0.7,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.04),
                // Animated Title with enhanced typography
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: 1.0,
                  child: Text(
                    item.title,
                    style: getBoldStyle(
                      fontSize: titleFontSize,
                      fontFamily: FontConstant.cairo,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                // Animated Description with better spacing
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: 1.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.04,
                    ),
                    child: Text(
                      item.description,
                      style: getRegularStyle(
                        fontSize: descriptionFontSize,
                        color: AppColors.textSecondary,
                        fontFamily: FontConstant.cairo,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppColors.primary.withValues(alpha: 0.05),
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.03),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.02),
                ),
              ),
            ),
            // Main content
            PageView.builder(
              controller: _pageController,
              reverse: Directionality.of(context) == TextDirection.rtl,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingItems.length,
              itemBuilder: (context, index) {
                return _buildOnboardingPage(_onboardingItems[index]);
              },
            ),
            // Skip button
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              right: 20,
              child: OnboardingSkipButton(
                onSkip: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
            ),
            // Navigation controls
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 25,
              left: 0,
              right: 0,
              child: OnboardingBottomSection(
                currentPage: _currentPage,
                totalPages: _onboardingItems.length,
                onNext: _nextPage,
                onPrevious: _previousPage,
                pageController: _pageController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
