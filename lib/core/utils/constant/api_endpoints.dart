class ApiEndpoints {
  static const String baseUrl = 'https://node-backend-railway-bashraai-production.up.railway.app/api/';
  
  // Auth endpoints
  static const String register = 'auth-user/register';
  static const String verifyOtp = 'auth-user/verify-otp';
  static const String login = 'auth-user/login';
  static const String logout = 'auth-user/logout';
  static const String resendOtp = 'auth-user/resend-otp';
  
  // Password reset endpoints
  static const String requestPasswordResetOtp = 'auth-user/request-password-reset-otp';
  static const String verifyPasswordResetOtp = 'auth-user/verify-password-reset-otp';
  static const String resetPassword = 'auth-user/reset-password';
}
