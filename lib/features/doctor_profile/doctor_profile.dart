import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/utils/constant/font_manger.dart';
import '../../core/utils/constant/styles_manger.dart';
import '../../core/utils/theme/app_colors.dart';
import './widgets/doctor_about_section_widget.dart';
import './widgets/doctor_availability_calendar_widget.dart';
import './widgets/doctor_contact_options_widget.dart';
import './widgets/doctor_education_widget.dart';
import './widgets/doctor_hero_section_widget.dart';
import './widgets/doctor_location_widget.dart';
import './widgets/doctor_reviews_widget.dart';
import './widgets/doctor_specializations_widget.dart';
import './widgets/doctor_working_hours_widget.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool isFavorite = false;
  bool isLoading = true;

  // Mock doctor data
  final Map<String, dynamic> doctorData = {
    "id": "dr_001",
    "arabicName": "د. أحمد محمد الخليل",
    "englishName": "Dr. Ahmed Mohammed Al-Khalil",
    "photo":
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
    "specialty": "أخصائي الأمراض الجلدية والتناسلية",
    "rating": 4.8,
    "reviewCount": 247,
    "experience": 15,
    "arabicBio":
        "د. أحمد الخليل هو أخصائي أمراض جلدية معتمد مع أكثر من 15 عامًا من الخبرة في تشخيص وعلاج الأمراض الجلدية المختلفة. حاصل على شهادة البورد الأمريكي في الأمراض الجلدية ومتخصص في علاج الأكزيما، الصدفية، وسرطان الجلد.",
    "medicalBackground":
        "تخرج من كلية الطب بجامعة الملك سعود وأكمل تدريبه التخصصي في مستشفى الملك فيصل التخصصي. شارك في العديد من الأبحاث الطبية المنشورة في المجلات العلمية المحكمة.",
    "specializations": [
      {
        "arabicName": "علاج الأكزيما والحساسية الجلدية",
        "description":
            "تشخيص وعلاج جميع أنواع الأكزيما والحساسية الجلدية باستخدام أحدث الطرق العلاجية"
      },
      {
        "arabicName": "علاج الصدفية",
        "description":
            "علاج متقدم للصدفية باستخدام العلاجات البيولوجية والضوئية"
      },
      {
        "arabicName": "فحص وعلاج سرطان الجلد",
        "description": "الكشف المبكر وعلاج سرطان الجلد بأنواعه المختلفة"
      },
      {
        "arabicName": "علاج حب الشباب والندبات",
        "description":
            "علاج شامل لحب الشباب وإزالة الندبات بالليزر والتقشير الكيميائي"
      }
    ],
    "education": [
      {
        "degree": "بكالوريوس الطب والجراحة",
        "institution": "جامعة الملك سعود - كلية الطب",
        "year": "2005"
      },
      {
        "degree": "ماجستير الأمراض الجلدية",
        "institution": "جامعة الملك فيصل - كلية الطب",
        "year": "2009"
      }
    ],
    "certifications": [
      {
        "name": "البورد السعودي للأمراض الجلدية",
        "issuer": "الهيئة السعودية للتخصصات الصحية",
        "year": "2010"
      },
      {
        "name": "شهادة الليزر الطبي",
        "issuer": "الأكاديمية الأمريكية للأمراض الجلدية",
        "year": "2012"
      },
      {
        "name": "شهادة علاج السرطان الجلدي",
        "issuer": "المعهد الوطني للسرطان",
        "year": "2015"
      }
    ],
    "workingHours": {
      "sunday": {"start": "9:00 AM", "end": "5:00 PM", "available": true},
      "monday": {"start": "9:00 AM", "end": "5:00 PM", "available": true},
      "tuesday": {"start": "1:00 PM", "end": "9:00 PM", "available": true},
      "wednesday": {"start": "9:00 AM", "end": "5:00 PM", "available": true},
      "thursday": {"start": "9:00 AM", "end": "1:00 PM", "available": true},
      "friday": {"start": "", "end": "", "available": false},
      "saturday": {"start": "", "end": "", "available": false}
    },
    "location": {
      "address": "1234 طريق الملك فهد، الرياض، المملكة العربية السعودية",
      "latitude": 24.7136,
      "longitude": 46.6753,
      "clinicName": "عيادة ديرما كير"
    },
    "contact": {"phone": "+966114670000", "email": "info@dermatology.com"},
    "reviews": [
      {
        "reviewerName": "فاطمة علي",
        "reviewerPhoto":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?fm=jpg&q=60&w=300&ixlib=rb-4.0.3",
        "rating": 5,
        "reviewText":
            "دكتور أحمد رائع جداً، استمع لمشكلتي بعناية وقدم لي العلاج المناسب. تحسنت بشرتي بشكل ملحوظ خلال فترة قصيرة. أنصح به بشدة!",
        "helpfulVotes": 12,
        "date": "2023-05-15"
      },
      {
        "reviewerName": "محمد عبدالله",
        "reviewerPhoto":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=300&ixlib=rb-4.0.3",
        "rating": 4,
        "reviewText":
            "تجربة جيدة جداً، الطبيب محترف والعيادة نظيفة. العيب الوحيد هو صعوبة الحصول على موعد قريب.",
        "helpfulVotes": 5,
        "date": "2023-04-22"
      }
    ],
    "availableDays": [
      {
        "date": "2023-06-10",
        "timeSlots": [
          {"time": "09:00 ص", "available": true},
          {"time": "09:30 ص", "available": false},
          {"time": "10:00 ص", "available": true},
          {"time": "10:30 ص", "available": true},
          {"time": "11:00 ص", "available": false},
          {"time": "11:30 ص", "available": true}
        ]
      },
      {
        "date": "2023-06-11",
        "timeSlots": [
          {"time": "09:00 ص", "available": true},
          {"time": "09:30 ص", "available": true},
          {"time": "10:00 ص", "available": true}
        ]
      },
      {
        "date": "2023-06-12",
        "timeSlots": []
      },
      {
        "date": "2023-06-13",
        "timeSlots": [
          {"time": "01:00 م", "available": true},
          {"time": "01:30 م", "available": true},
          {"time": "02:00 م", "available": false}
        ]
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _loadDoctorData();
  }

  Future<void> _loadDoctorData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _shareProfile() {
    print("Sharing profile...");
  }

  void _bookAppointment() {
    print("Booking appointment...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? _buildLoadingState() : _buildContent(context),
      floatingActionButton: isLoading ? null : _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            "جاري تحميل بيانات الطبيب...",
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        _buildAppBar(context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DoctorHeroSectionWidget(
                  doctorData: doctorData,
                  onFavoriteToggle: _toggleFavorite,
                  isFavorite: isFavorite,
                ),
                DoctorAboutSectionWidget(doctorData: doctorData),
                DoctorSpecializationsWidget(doctorData: doctorData),
                DoctorEducationWidget(doctorData: doctorData),
                DoctorWorkingHoursWidget(doctorData: doctorData),
                DoctorLocationWidget(doctorData: doctorData),
                DoctorContactOptionsWidget(doctorData: doctorData),
                DoctorAvailabilityCalendarWidget(doctorData: doctorData),
                DoctorReviewsWidget(doctorData: doctorData),
                SizedBox(height: screenHeight * 0.12),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1);
  }

  Widget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + (screenWidth * 0.04),
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
        bottom: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAppBarIcon(context, Icons.arrow_back_ios_new, () => Navigator.pop(context)),
          Text(
            "ملف الطبيب",
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontFamily: FontConstant.cairo,
            ),
          ),
          _buildAppBarIcon(context, Icons.share_outlined, _shareProfile),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(BuildContext context, IconData icon, VoidCallback onTap) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: screenWidth * 0.05,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton.extended(
        onPressed: _bookAppointment,
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        label: Text(
          "احجز موعد الآن",
          style: getBoldStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: FontConstant.cairo,
          ),
        ),
        icon: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
    ).animate().slideY(begin: 2, duration: 600.ms, delay: 200.ms).fadeIn();
  }
}