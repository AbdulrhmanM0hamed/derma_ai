import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/features/doctor_booking/presentation/widgets/time_slot_picker.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/doctor_card.dart';
import '../widgets/date_picker.dart';


class DoctorDetailsPage extends StatefulWidget {
  const DoctorDetailsPage({super.key});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final bool _isBookingInProgress = false;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;

  // Dummy data for the doctor
  final _doctor =  DoctorModel(
    id: '1',
    name: 'Dr. Arlene L. Johnson',
    specialty: 'Dermatologist',
    imageUrl:
        'https://img.freepik.com/free-photo/pleased-young-female-doctor-wearing-medical-robe-stethoscope-around-neck-standing-with-closed-posture_409827-254.jpg?w=996&t=st=1693507269~exp=1693507869~hmac=80b8dd423021e54c6931a7045326b52869c031c1833a62b81623b7e7b6b1b5a8',
    rating: 4.8,
    reviewCount: 230,
    hospital: 'New York, USA',
    consultationFee: 150,
    experience: '15 years',
    about:
        'Dr. Arlene L. Johnson is a board-certified dermatologist with over 15 years of experience in medical, surgical, and cosmetic dermatology. She is dedicated to providing her patients with the highest quality of care and is passionate about helping them achieve healthy, beautiful skin.',
    services: [
      'Acne Treatment',
      'Skin Cancer Screening',
      'Botox',
      'Fillers',
      'Laser Hair Removal',
    ],
    education: [
      'MD, Harvard Medical School',
      'Residency, Dermatology, New York-Presbyterian Hospital',
    ],
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _bookAppointment() {
    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time slot to book an appointment.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text(
          'Book an appointment with ${_doctor.name} on ${DateFormat.yMMMd().format(_selectedDate)} at $_selectedTimeSlot?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showBookingSuccess();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showBookingSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Appointment Booked!',
                    style: getBoldStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your appointment with ${_doctor.name} has been successfully booked.',
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Done',
                    onPressed: () => Navigator.of(context).pop(),
                    type: ButtonType.primary,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDoctorInfo(),
                const SizedBox(height: 16),
                _buildTabBar(),
                _buildTabContent(),
                const SizedBox(height: 16),
                _buildAppointmentSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'doctor_image_${_doctor.id}',
          child: CachedNetworkImage(
            imageUrl: _doctor.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha:0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border),
          ),
          onPressed: () {
            // Add to favorites
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDoctorInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _doctor.name,
                      style: getBoldStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontFamily: FontConstant.cairo,
                      ),
                    ).animate(effects: fadeInSlide(
                      duration: 300.ms,
                      beginX: -0.1,
                    )),
                    const SizedBox(height: 4),
                    Text(
                      _doctor.specialty,
                      style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontFamily: FontConstant.cairo,
                      ),
                    ).animate(effects: fadeInSlide(
                      duration: 300.ms,
                      delay: 100.ms,
                      beginX: -0.1,
                    )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _doctor.rating.toString(),
                      style: getBoldStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    Text(
                      ' (${_doctor.reviewCount})',
                      style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                  ],
                ),
              ).animate(effects: fadeIn(
                duration: 300.ms,
                delay: 200.ms,
              )),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn(Icons.location_on, _doctor.hospital),
              _buildInfoColumn(Icons.work, '10 years'),
              _buildInfoColumn(Icons.people, '1.5k+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String text, {bool isLast = false}) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontFamily: FontConstant.cairo,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!isLast)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: VerticalDivider(
                color: AppColors.border,
                thickness: 1,
                indent: 2,
                endIndent: 2,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: AppLocalizations.of(context)!.about),
          Tab(text: AppLocalizations.of(context)!.experience),
          Tab(text: AppLocalizations.of(context)!.reviews),
        ],
        labelStyle: getSemiBoldStyle(color: AppColors.primary, fontSize: 14, fontFamily: FontConstant.cairo),
        unselectedLabelStyle: getRegularStyle(color: AppColors.textSecondary, fontSize: 14, fontFamily: FontConstant.cairo),
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height: 200,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildAboutTab(),
          _buildExperienceTab(),
          _buildReviewsTab(),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.about,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _doctor.about ?? '',
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.services,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (_doctor.services ?? []).map((service) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  service,
                  style: getRegularStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.education,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Column(
            children: (_doctor.education ?? []).map((education) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.school,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        education,
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    // Dummy reviews data
    final reviews = [
      {
        'name': 'John Doe',
        'rating': 5.0,
        'date': '2 weeks ago',
        'comment': 'Dr. Johnson was very thorough and took the time to explain my condition and treatment options.',
        'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
      },
      {
        'name': 'Jane Smith',
        'rating': 4.5,
        'date': '1 month ago',
        'comment': 'Great doctor, very knowledgeable and professional. The wait time was a bit long though.',
        'avatar': 'https://randomuser.me/api/portraits/women/32.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.patientReviews,
                style: getBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontFamily: FontConstant.cairo,
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all reviews
                },
                child: Text(
                  AppLocalizations.of(context)!.viewAll,
                  style: getSemiBoldStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: reviews.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(
                        review['avatar'] as String,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review['name'] as String,
                                style: getSemiBoldStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                              Text(
                                review['date'] as String,
                                style: getRegularStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < (review['rating'] as double).floor()
                                    ? Icons.star
                                    : i < (review['rating'] as double)
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            review['comment'] as String,
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book Appointment',
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Date',
            style: getMediumStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 8),
          DatePicker(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
                _selectedTimeSlot = null; // Reset time slot when date changes
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Available Time Slots',
            style: getMediumStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 8),
          TimeSlotPicker(
            selectedTimeSlot: _selectedTimeSlot,
            onTimeSlotSelected: (timeSlot) {
              setState(() {
                _selectedTimeSlot = timeSlot;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consultation Fee',
                  style: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                Text(
                  '\$${_doctor.consultationFee}',
                  style: getBoldStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomButton(
              text: 'Book Appointment',
              onPressed: _bookAppointment,
              isLoading: _isBookingInProgress,
              type: ButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }
}