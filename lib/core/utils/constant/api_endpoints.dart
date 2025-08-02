class ApiEndpoints {
  static const String baseUrl = 'https://node-backend-railway-bashraai-production.up.railway.app/api/';
  
  // Auth endpoints
  static const String register = 'auth-user/register';
  static const String verifyOtp = 'auth-user/verify-otp';
  static const String login = 'auth-user/login';
  static const String resendOtp = 'auth-user/resend-otp';
}
