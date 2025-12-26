import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/appointment_model.dart';
import '../widgets/appointment_type_selector.dart';
import '../widgets/date_time_selector.dart';
import '../widgets/patient_info_form.dart';
import '../widgets/symptoms_description_form.dart';
import 'appointment_confirmation_page.dart';

class BookAppointmentPage extends StatefulWidget {
  final Map<String, dynamic> doctorData;

  const BookAppointmentPage({
    super.key,
    required this.doctorData,
  });

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form data
  AppointmentType _selectedAppointmentType = AppointmentType.consultation;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  String _patientName = '';
  String _patientPhone = '';
  String _patientEmail = '';
  String _symptoms = '';
  String _additionalNotes = '';
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _canProceedToNextStep() {
    switch (_currentStep) {
      case 0:
        return true; // Always can proceed from appointment type selection
      case 1:
        return _selectedDate != null && _selectedTimeSlot != null;
      case 2:
        return _patientName.isNotEmpty && 
               _patientPhone.isNotEmpty && 
               _patientEmail.isNotEmpty;
      case 3:
        return _symptoms.isNotEmpty;
      default:
        return false;
    }
  }

  bool _canProceedToBooking() {
    return _selectedDate != null &&
           _selectedTimeSlot != null &&
           _patientName.isNotEmpty &&
           _patientPhone.isNotEmpty &&
           _patientEmail.isNotEmpty &&
           _symptoms.isNotEmpty;
  }

  Future<void> _bookAppointment() async {
    // Only validate form if we're on the patient info step (step 2)
    if (_currentStep == 2 && !_formKey.currentState!.validate()) return;
    
    // Check if all required data is available
    if (!_canProceedToBooking()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إكمال جميع البيانات المطلوبة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    final appointment = AppointmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      doctorId: widget.doctorData['id'] ?? '',
      doctorName: widget.doctorData['arabicName'] ?? '',
      doctorSpecialty: widget.doctorData['specialty'] ?? '',
      doctorPhoto: widget.doctorData['photo'] ?? '',
      patientName: _patientName,
      patientPhone: _patientPhone,
      patientEmail: _patientEmail,
      appointmentDate: _selectedDate!,
      appointmentTime: _selectedTimeSlot!,
      appointmentType: _selectedAppointmentType.arabicName,
      symptoms: _symptoms,
      additionalNotes: _additionalNotes,
      status: AppointmentStatus.pending,
      consultationFee: 200.0, // Default fee
      clinicAddress: widget.doctorData['location']?['address'] ?? '',
      createdAt: DateTime.now(),
    );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentConfirmationPage(
            appointment: appointment,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildAppointmentTypeStep(),
                  _buildDateTimeStep(),
                  _buildPatientInfoStep(),
                  _buildSymptomsStep(),
                ],
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'حجز موعد',
        style: getBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: List.generate(_totalSteps, (index) {
              final isActive = index <= _currentStep;
              final isCompleted = index < _currentStep;
              
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index == _totalSteps - 1 ? 0 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepLabel('نوع الموعد', 0),
              _buildStepLabel('التاريخ والوقت', 1),
              _buildStepLabel('بيانات المريض', 2),
              _buildStepLabel('وصف الحالة', 3),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
  }

  Widget _buildStepLabel(String label, int stepIndex) {
    final isActive = stepIndex == _currentStep;
    return Text(
      label,
      style: getRegularStyle(
        fontFamily: FontConstant.cairo,
        fontSize: 12,
        color: isActive ? AppColors.primary : Colors.grey[600],
      ),
    );
  }

  Widget _buildAppointmentTypeStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            'اختر نوع الموعد',
            'حدد نوع الاستشارة المطلوبة',
            Icons.medical_services_outlined,
          ),
          const SizedBox(height: 24),
          AppointmentTypeSelector(
            selectedType: _selectedAppointmentType,
            onTypeSelected: (type) {
              setState(() {
                _selectedAppointmentType = type;
              });
            },
          ),
          const SizedBox(height: 24),
          _buildDoctorInfoCard(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3);
  }

  Widget _buildDateTimeStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            'اختر التاريخ والوقت',
            'حدد الموعد المناسب لك',
            Icons.calendar_today_outlined,
          ),
          const SizedBox(height: 24),
          DateTimeSelector(
            doctorData: widget.doctorData,
            selectedDate: _selectedDate,
            selectedTimeSlot: _selectedTimeSlot,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
                _selectedTimeSlot = null; // Reset time when date changes
              });
            },
            onTimeSlotSelected: (timeSlot) {
              setState(() {
                _selectedTimeSlot = timeSlot;
              });
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3);
  }

  Widget _buildPatientInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepHeader(
              'بيانات المريض',
              'أدخل بياناتك الشخصية',
              Icons.person_outline,
            ),
            const SizedBox(height: 24),
            PatientInfoForm(
              patientName: _patientName,
              patientPhone: _patientPhone,
              patientEmail: _patientEmail,
              onNameChanged: (value) {
                setState(() {
                  _patientName = value;
                });
              },
              onPhoneChanged: (value) {
                setState(() {
                  _patientPhone = value;
                });
              },
              onEmailChanged: (value) {
                setState(() {
                  _patientEmail = value;
                });
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3);
  }

  Widget _buildSymptomsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            'وصف الحالة',
            'اشرح الأعراض والمشكلة الصحية',
            Icons.description_outlined,
          ),
          const SizedBox(height: 24),
          SymptomsDescriptionForm(
            symptoms: _symptoms,
            additionalNotes: _additionalNotes,
            onSymptomsChanged: (value) {
              setState(() {
                _symptoms = value;
              });
            },
            onNotesChanged: (value) {
              setState(() {
                _additionalNotes = value;
              });
            },
          ),
          const SizedBox(height: 24),
          _buildAppointmentSummary(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.3);
  }

  Widget _buildStepHeader(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.doctorData['photo'] ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctorData['arabicName'] ?? '',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.doctorData['specialty'] ?? '',
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.doctorData['rating'] ?? 0.0}',
                      style: getSemiBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${widget.doctorData['reviewCount'] ?? 0} تقييم)',
                      style: getRegularStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الموعد',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('نوع الموعد', _selectedAppointmentType.arabicName),
          _buildSummaryRow(
            'التاريخ', 
            _selectedDate != null 
                ? DateFormat('EEEE، d MMMM yyyy', 'ar').format(_selectedDate!)
                : 'غير محدد'
          ),
          _buildSummaryRow('الوقت', _selectedTimeSlot ?? 'غير محدد'),
          _buildSummaryRow('اسم المريض', _patientName),
          _buildSummaryRow('رقم الهاتف', _patientPhone),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'رسوم الاستشارة',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                '200 ريال',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'السابق',
                  style: getSemiBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isLoading 
                  ? null 
                  : _currentStep == _totalSteps - 1
                      ? _bookAppointment
                      : _canProceedToNextStep()
                          ? _nextStep
                          : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      _currentStep == _totalSteps - 1 ? 'تأكيد الحجز' : 'التالي',
                      style: getBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
