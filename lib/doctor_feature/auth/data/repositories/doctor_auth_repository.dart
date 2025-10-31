import 'package:dio/dio.dart';
import '../../../../core/error/api_exception.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../../../core/utils/constant/api_endpoints.dart';
import '../../../../user_features/auth/data/models/auth_models.dart';

abstract class DoctorAuthRepository {
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

class DoctorAuthRepositoryImpl implements DoctorAuthRepository {
  final ApiService _apiService;
  final DioClient _dioClient = DioClient.instance;
  final TokenStorageService _tokenStorage;

  DoctorAuthRepositoryImpl(this._apiService, this._tokenStorage);

  @override
  Future<LoginResponse> login(LoginRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.loginDoctor,
        data: request.toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } on ApiException catch (e) {
      // التحقق من أن الخطأ 403 ويحتوي على accountNotVerified
      if (e.statusCode == 403 && e.response?.data != null) {
        final data = e.response!.data;
        
        if (data is Map<String, dynamic> && data.containsKey('accountNotVerified')) {
          // تحويل الـ error response إلى LoginResponse
          return LoginResponse.fromJson(data);
        }
      }
      
      // إعادة رمي الخطأ إذا لم يكن account not verified
      rethrow;
    }
  }

  @override
  Future<RegisterResponse> register(SignupRequestModel request) async {
    final response = await _apiService.post<RegisterResponse>(
      ApiEndpoints.registerDoctor,
      data: request.toJson(),
      fromJson: (data) => RegisterResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> logout() async {
    final accessToken = _tokenStorage.accessToken;
    
    final response = await _dioClient.post(
      ApiEndpoints.logoutDoctor,
      options: Options(
        headers: accessToken != null ? {
          'Authorization': 'Bearer $accessToken',
        } : {},
      ),
    );
    
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<BaseResponse> forgetPassword(ForgetPasswordRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.requestPasswordResetOtpDoctor,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> checkOtp(CheckOtpRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.verifyOtpDoctor,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> changePassword(ChangePasswordRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.resetPasswordDoctor,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> refreshToken() async {
    final response = await _apiService.post<RefreshTokenResponse>(
      ApiEndpoints.refreshTokenDoctor,
      fromJson: (data) => RefreshTokenResponse.fromJson(data),
    );

    return response.data.toJson();
  }

  @override
  Future<BaseResponse> resendVerificationEmail(String email) async {
    final response = await _apiService.post<BaseResponse>(
      'auth-doctor/resend-verify-email',
      data: {'email': email},
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequestModel request) async {
    final response = await _apiService.post<BaseResponse>(
      ApiEndpoints.resendOtpDoctor,
      data: request.toJson(),
      fromJson: (data) => BaseResponse.fromJson(data),
    );
    return response;
  }

}
