import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../doctor_booking/presentation/widgets/doctor_card.dart';
import '../../../ai_diagnosis/presentation/widgets/diagnosis_card.dart';
import '../widgets/feature_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  
  // Dummy data for demonstration
  final List<DoctorModel> _topDoctors = [
    DoctorModel(
      id: '1',
      name: 'Dr. Sarah Johnson',
      specialty: 'Dermatologist',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      rating: 4.9,
      reviewCount: 124,
      hospital: 'Mayo Clinic',
      experience: '10 years',
      consultationFee: 120,
      isAvailable: true,
    ),
    DoctorModel(
      id: '2',
      name: 'Dr. Michael Chen',
      specialty: 'Dermatologist',
      imageUrl: 'https://randomuser.me/api/portraits/men/46.jpg',
      rating: 4.8,
      reviewCount: 98,
      hospital: 'Cleveland Clinic',
      experience: '8 years',
      consultationFee: 100,
      isAvailable: true,
    ),
    DoctorModel(
      id: '3',
      name: 'Dr. Emily Rodriguez',
      specialty: 'Dermatologist',
      imageUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
      rating: 4.7,
      reviewCount: 87,
      hospital: 'Johns Hopkins Hospital',
      experience: '12 years',
      consultationFee: 150,
      isAvailable: false,
    ),
  ];

  final List<DiagnosisModel> _recentDiagnoses = [
    DiagnosisModel(
      id: '1',
      diseaseName: 'Atopic Dermatitis',
      description: 'Atopic dermatitis is a chronic inflammatory skin condition characterized by dry, itchy skin and rashes. It is commonly associated with allergies and asthma.',
      imageUrl: 'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2013/11/15/17/35/ds00986_-ds00987_-ds00674_-ds00821_-ds00842_-ds00843_-ds00844_-ds01047_-ds01060_-ds01122_-ds01145_-my01331_im03450_r7_skinirritthu_jpg.jpg',
      confidence: 0.92,
      diagnosisDate: DateTime.now().subtract(const Duration(days: 2)),
      symptoms: ['Dry skin', 'Itching', 'Redness', 'Rash', 'Scaly patches'],
      treatments: ['Moisturizers', 'Topical corticosteroids', 'Antihistamines', 'Avoid triggers', 'Keep skin hydrated'],
      severity: 'medium',
    ),
    DiagnosisModel(
      id: '2',
      diseaseName: 'Psoriasis',
      description: 'Psoriasis is a chronic autoimmune condition that causes rapid skin cell growth, resulting in thick, red patches with silvery scales. It can affect various parts of the body.',
      imageUrl: 'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2013/11/15/17/39/ds00193_-ds00815_-ds01306_-my01137_im03430_psoriasisthu_jpg.jpg',
      confidence: 0.85,
      diagnosisDate: DateTime.now().subtract(const Duration(days: 10)),
      symptoms: ['Red patches', 'Silvery scales', 'Dry, cracked skin', 'Itching', 'Burning sensation'],
      treatments: ['Topical treatments', 'Light therapy', 'Oral medications', 'Biologics', 'Lifestyle changes'],
      severity: 'high',
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    _buildFeaturesSection(),
                    const SizedBox(height: 24),
                    _buildTopDoctorsSection(),
                    const SizedBox(height: 24),
                    _buildRecentDiagnosesSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'D',
                style: getBoldStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.appName,
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // Navigate to notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {
            // Navigate to profile
          },
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Animate(
          effects: fadeInSlide(
            duration: 300.ms,
            beginX: -0.1,
          ),
          child: Text(
            AppLocalizations.of(context)!.helloUser('Ahmed'),
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Animate(
          effects: fadeInSlide(
            duration: 300.ms,
            delay: 100.ms,
            beginX: -0.1,
          ),
          child: Text(
            AppLocalizations.of(context)!.skinHelpPrompt,
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Animate(
          effects: fadeInScaleUp(
            duration: 400.ms,
            delay: 200.ms,
            begin: 0.95,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.aiSkinDiagnosis,
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.diagnosisDescription,
                        style: getRegularStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: AppLocalizations.of(context)!.startDiagnosis,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.diagnosis);
                        },
                        type: ButtonType.secondary,
                        icon: Icons.camera_alt_outlined,
                        height: 44,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.health_and_safety_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'title': AppLocalizations.of(context)!.findDoctors,
        'icon': Icons.person_search_outlined,
        'color': AppColors.primary,
        'onTap': () {
          // Navigate to doctor listing
        },
      },
      {
        'title': AppLocalizations.of(context)!.appointments,
        'icon': Icons.calendar_today_outlined,
        'color': AppColors.secondary,
        'onTap': () {
          // Navigate to appointments
        },
      },
      {
        'title': AppLocalizations.of(context)!.myDiagnoses,
        'icon': Icons.analytics_outlined,
        'color': AppColors.primary,
        'onTap': () {
          // Navigate to diagnoses history
        },
      },
      {
        'title': AppLocalizations.of(context)!.skinTips,
        'icon': Icons.lightbulb_outline,
        'color': Colors.purple,
        'onTap': () {
          // Navigate to skin care tips
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.quickAccess,
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontFamily: FontConstant.cairo,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return Animate(
              effects: fadeInSlide(
                duration: 300.ms,
                delay: Duration(milliseconds: 100 * index),
                beginY: 0.1,
              ),
              child: FeatureCard(
                title: feature['title'] as String,
                icon: feature['icon'] as IconData,
                color: feature['color'] as Color,
                onTap: feature['onTap'] as VoidCallback,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopDoctorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.topDermatologists,
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontFamily: FontConstant.cairo,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all doctors
              },
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: getSemiBoldStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _topDoctors.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final doctor = _topDoctors[index];
            return Animate(
              effects: fadeInSlide(
                duration: 300.ms,
                delay: Duration(milliseconds: 100 * index),
                beginY: 0.1,
              ),
              child: DoctorCard(
                doctor: doctor,
                onTap: () {
                  // Navigate to doctor details
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentDiagnosesSection() {
    if (_recentDiagnoses.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.recentDiagnoses,
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontFamily: FontConstant.cairo,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all diagnoses
              },
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: getSemiBoldStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentDiagnoses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final diagnosis = _recentDiagnoses[index];
            return Animate(
              effects: fadeInSlide(
                duration: 300.ms,
                delay: Duration(milliseconds: 100 * index),
                beginY: 0.1,
              ),
              child: DiagnosisCard(
                diagnosis: diagnosis,
                onTap: () {
                  // Navigate to diagnosis details
                },
              ),
            );
          },
        ),
      ],
    );
  }
}