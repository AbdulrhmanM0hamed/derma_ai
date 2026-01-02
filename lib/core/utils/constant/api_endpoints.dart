class ApiEndpoints {
  static const String baseUrl = 'https://api.bashraai.com/api/';

  // Auth endpoints
  static const String register = 'auth-user/register';
  static const String verifyOtp = 'auth-user/verify-otp';
  static const String login = 'auth-user/login';
  static const String logout = 'auth-user/logout';
  static const String resendOtp = 'auth-user/resend-otp';
  static const String refreshToken = 'auth-user/refresh-token';
  // Doctor Auth endpoints
  static const String registerDoctor = 'auth-doctor/register';
  static const String verifyOtpDoctor = 'auth-doctor/verify-otp';
  static const String loginDoctor = 'auth-doctor/login';
  static const String logoutDoctor = 'auth-doctor/logout';
  static const String resendOtpDoctor = 'auth-doctor/resend-otp';
  static const String refreshTokenDoctor = 'auth-doctor/refresh-token';

  // Password reset endpoints
  static const String requestPasswordResetOtp =
      'auth-user/request-password-reset-otp';
  static const String verifyPasswordResetOtp =
      'auth-user/verify-password-reset-otp';
  static const String resetPassword = 'auth-user/reset-password';
  // Password reset endpoints
  static const String requestPasswordResetOtpDoctor =
      'auth-doctor/request-password-reset-otp';
  static const String verifyPasswordResetOtpDoctor =
      'auth-doctor/verify-password-reset-otp';
  static const String resetPasswordDoctor = 'auth-doctor/reset-password';

  // Health Tips endpoints
  static const String dailyTipsActive = 'health-tips/daily-tips/active';
  static const String dailyTipsLatest = 'health-tips/daily-tips/latest';

  //article
  static const String medicalArticlesActive =
      "health-tips/medical-articles/active";
  static String medicalArticlesActiveByID(int id) =>
      "health-tips/medical-articles/$id";

  // Skin Diseases endpoints
  static const String skinDiseasesActive = "health-tips/skin-diseases/active";
  static String skinDiseaseById(int id) => "health-tips/skin-diseases/$id";

  // Profile endpoints
  static const String profileBasic = '/profile-user/basic';
  static const String profilePicture = '/profile-user/picture';

  // Doctor Profile endpoints
  static const String doctorProfile = 'profile-doctor/';
  static const String doctorProfilePicture = 'profile-doctor/picture';

  // Location endpoints
  static const String countries = 'countries-cities/countries';
  static String cities(int countryId) => 'countries-cities/cities/$countryId';
  static String regions(int cityId) => 'countries-cities/regions/$cityId';

  // Packages endpoints
  static const String packageFeatures = 'public/features';
  static const String packages = 'public/packages';
  static String packageById(int id) => 'public/packages/$id';
  static const String packagesComparison = 'public/packages/comparison';
  static const String packagesFeatured = 'public/packages/featured';
  static const String packagesCheapest = 'public/packages/cheapest';
  static const String packagesPremium = 'public/packages/premium';
}
