class AppConstants {
  // App Info
  static const String appName = 'DermaAI';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://api.derma-ai.example.com';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String doctorsEndpoint = '/doctors';
  static const String appointmentsEndpoint = '/appointments';
  static const String diagnosisEndpoint = '/diagnosis';
  static const String userProfileEndpoint = '/user/profile';
  
  // Local Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Pagination
  static const int defaultPageSize = 10;
  
  // Animation Durations
  static const int shortAnimationDuration = 200; // milliseconds
  static const int mediumAnimationDuration = 500; // milliseconds
  static const int longAnimationDuration = 800; // milliseconds
  
  // Image Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String onboardingImagePath1 = 'assets/images/onboarding1.svg';
  static const String onboardingImagePath2 = 'assets/images/onboarding2.svg';
  static const String onboardingImagePath3 = 'assets/images/onboarding3.svg';
  static const String placeholderDoctorImage = 'assets/images/doctor_placeholder.png';
  static const String placeholderUserImage = 'assets/images/user_placeholder.png';
  static const String aiLogo = 'assets/images/ai_logo.png';

  
  // ML Model
  static const String mlModelPath = 'assets/ml/skin_disease_model.tflite';
  static const String mlLabelsPath = 'assets/ml/skin_disease_labels.txt';
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String connectionErrorMessage = 'No internet connection. Please check your network.';
  static const String authErrorMessage = 'Authentication failed. Please check your credentials.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String validationErrorMessage = 'Please check the information you provided.';
  
  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registerSuccessMessage = 'Registration successful!';
  static const String appointmentBookedMessage = 'Appointment booked successfully!';
  static const String profileUpdatedMessage = 'Profile updated successfully!';
  
  // Feature Flags
  static const bool enableDarkMode = false;
  static const bool enableNotifications = true;
  static const bool enableOfflineMode = true;
  
  // Permissions
  static const List<String> requiredPermissions = ['camera', 'storage'];
  
  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  static const String phonePattern = r'^\+?[0-9]{10,15}$';
}