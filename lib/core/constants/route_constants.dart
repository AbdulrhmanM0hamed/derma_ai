class RouteConstants {
  // Doctor Routes
  static const String doctorHome = '/doctor-home';
  static const String doctorProfile = '/doctor-profile';
  static const String doctorSettings = '/doctor-settings';
  
  // Patient Management
  static const String advancedPatients = '/advanced-patients';
  static const String patientDetails = '/patient-details';
  static const String addPatient = '/add-patient';
  static const String editPatient = '/edit-patient';
  
  // Appointment Management
  static const String advancedAppointments = '/advanced-appointments';
  static const String appointmentDetails = '/appointment-details';
  static const String addAppointment = '/add-appointment';
  static const String editAppointment = '/edit-appointment';
  
  // AI Diagnosis
  static const String doctorAiDiagnosis = '/doctor-ai-diagnosis';
  static const String diagnosisResults = '/diagnosis-results';
  static const String diagnosisHistory = '/diagnosis-history';
  
  // Prescriptions
  static const String prescriptions = '/prescriptions';
  static const String createPrescription = '/create-prescription';
  static const String prescriptionTemplates = '/prescription-templates';
  static const String medicationDatabase = '/medication-database';
  
  // Reports & Analytics
  static const String reports = '/reports';
  static const String analyticsDashboard = '/analytics-dashboard';
  static const String performanceReports = '/performance-reports';
  static const String revenueReports = '/revenue-reports';
  
  // Communication
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String videoCall = '/video-call';
  static const String chat = '/chat';
  
  // Settings & Configuration
  static const String clinicSettings = '/clinic-settings';
  static const String workingHours = '/working-hours';
  static const String servicePrices = '/service-prices';
  static const String notificationSettings = '/notification-settings';
  
  // Help & Support
  static const String helpCenter = '/help-center';
  static const String contactSupport = '/contact-support';
  static const String faq = '/faq';
  static const String aboutApp = '/about-app';
  
  // Authentication (if needed)
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  
  // Onboarding
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String setupProfile = '/setup-profile';
  
  // Error Pages
  static const String notFound = '/not-found';
  static const String error = '/error';
  static const String maintenance = '/maintenance';
  
  // External Links (for reference)
  static const String privacyPolicy = '/privacy-policy';
  static const String termsOfService = '/terms-of-service';
  static const String dataPolicy = '/data-policy';
}

class RouteArguments {
  // Patient Arguments
  static const String patientId = 'patientId';
  static const String patientData = 'patientData';
  
  // Appointment Arguments
  static const String appointmentId = 'appointmentId';
  static const String appointmentData = 'appointmentData';
  static const String selectedDate = 'selectedDate';
  static const String selectedTime = 'selectedTime';
  
  // Diagnosis Arguments
  static const String diagnosisId = 'diagnosisId';
  static const String imageData = 'imageData';
  static const String diagnosisResults = 'diagnosisResults';
  
  // Prescription Arguments
  static const String prescriptionId = 'prescriptionId';
  static const String templateId = 'templateId';
  static const String medicationId = 'medicationId';
  
  // Report Arguments
  static const String reportType = 'reportType';
  static const String dateRange = 'dateRange';
  static const String filterData = 'filterData';
  
  // General Arguments
  static const String title = 'title';
  static const String message = 'message';
  static const String data = 'data';
  static const String isEdit = 'isEdit';
  static const String returnRoute = 'returnRoute';
}
