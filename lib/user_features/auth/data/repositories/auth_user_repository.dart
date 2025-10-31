import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constant/api_endpoints.dart';
import '../models/auth_models.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequestModel request);
  Future<RegisterResponse> register(SignupRequestModel request);
  Future<BaseResponse> logout();
  Future<BaseResponse> forgetPassword(ForgetPasswordRequestModel request);
  Future<BaseResponse> checkOtp(CheckOtpRequestModel request);
  Future<BaseResponse> changePassword(ChangePasswordRequestModel request);
  Future<Map<String, dynamic>> refreshToken();
  Future<BaseResponse> resendVerificationEmail(String email);
  Future<BaseResponse> resendOtp(ResendOtpRequestModel request);
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<LoginResponse> login(LoginRequestModel request) async {
    final response = await _apiService.post<LoginResponse>(
      ApiEndpoints.login,
      data: request.toJson(),
      fromJson: (data) => LoginResponse.fromJson(data),
    );

    return response;
  }

  @override
  Future<RegisterResponse> register(SignupRequestModel request) async {
    final response = await _apiService.post<RegisterResponse>(
      ApiEndpoints.register,
      data: request.toJson(),
      fromJson: (data) => RegisterResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> logout() async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.logout,
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> forgetPassword(ForgetPasswordRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.requestPasswordResetOtp,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> checkOtp(CheckOtpRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> changePassword(ChangePasswordRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.resetPassword,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> refreshToken() async {
    final response = await _apiService.post<RefreshTokenResponse>(
      ApiEndpoints.refreshToken,
      fromJson: (data) => RefreshTokenResponse.fromJson(data),
    );

    return response.data.toJson();
  }

  @override
  Future<BaseResponse> resendVerificationEmail(String email) async {
    final response = await _apiService.post<BaseResponse>(
      'auth-user/resend-verify-email', // Add this endpoint if needed
      data: {'email': email},
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.resendOtp,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }
}
