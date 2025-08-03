import 'package:dio/dio.dart';

import '../../../../core/services/dio_service.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../../../core/utils/constant/api_endpoints.dart';
import '../models/login_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/verify_otp_model.dart';
import '../models/password_reset_request_model.dart';
import '../models/password_reset_response_model.dart';
import '../models/verify_password_reset_otp_model.dart';
import '../models/reset_password_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
  
  Future<RegisterResponseModel> register(RegisterRequestModel request);
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel request);
  Future<Map<String, dynamic>> resendOtp({
    required int userId,
    required String type,
  });
  
  Future<void> logout();
  
  // Password reset methods
  Future<PasswordResetResponseModel> requestPasswordResetOtp(PasswordResetRequestModel request);
  Future<VerifyPasswordResetOtpResponseModel> verifyPasswordResetOtp(VerifyPasswordResetOtpRequestModel request);
  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioService dioService;
  final TokenStorageService tokenStorageService;

  AuthRemoteDataSourceImpl({
    required this.dioService,
    required this.tokenStorageService,
  });

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioService.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    
    final loginResponse = LoginResponseModel.fromJson(response.data);
    
    // Save tokens if login is successful
    if (loginResponse.success && 
        loginResponse.accessToken != null &&
        loginResponse.refreshToken != null &&
        loginResponse.sessionToken != null) {
      await tokenStorageService.saveTokens(
        accessToken: loginResponse.accessToken!,
        refreshToken: loginResponse.refreshToken!,
        sessionToken: loginResponse.sessionToken!,
      );
      
      // Save user data
      if (loginResponse.userId != null &&
          loginResponse.userUuid != null &&
          loginResponse.userEmail != null &&
          loginResponse.userStatus != null) {
        await tokenStorageService.saveUserData(
          userId: loginResponse.userId!,
          userUuid: loginResponse.userUuid!,
          userEmail: loginResponse.userEmail!,
          userStatus: loginResponse.userStatus!,
        );
      }
    }
    
    return loginResponse;
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      return RegisterResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = DioService.handleError(e);
      return RegisterResponseModel.fromJson(errorData);
    } catch (e) {
      return RegisterResponseModel(
        success: false,
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.verifyOtp,
        data: request.toJson(),
      );

      return VerifyOtpResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = DioService.handleError(e);
      return VerifyOtpResponseModel.fromJson(errorData);
    } catch (e) {
      return VerifyOtpResponseModel(
        success: false,
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> resendOtp({
    required int userId,
    required String type,
  }) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.resendOtp,
        data: {
          'userId': userId,
          'type': type,
        },
      );

      return response.data;
    } on DioException catch (e) {
      return DioService.handleError(e);
    } catch (e) {
      return {
        'success': false,
        'message_en': 'An unexpected error occurred',
        'message_ar': 'حدث خطأ غير متوقع',
      };
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dioService.post(ApiEndpoints.logout);
    } catch (e) {
    } finally {
      await tokenStorageService.clearAll();
    }
  }

  @override
  Future<PasswordResetResponseModel> requestPasswordResetOtp(PasswordResetRequestModel request) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.requestPasswordResetOtp,
        data: request.toJson(),
      );
      
      return PasswordResetResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = DioService.handleError(e);
      return PasswordResetResponseModel.fromJson(errorData);
    } catch (e) {
      return PasswordResetResponseModel(
        success: false,
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      );
    }
  }

  @override
  Future<VerifyPasswordResetOtpResponseModel> verifyPasswordResetOtp(VerifyPasswordResetOtpRequestModel request) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.verifyPasswordResetOtp,
        data: request.toJson(),
      );
      
      return VerifyPasswordResetOtpResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = DioService.handleError(e);
      return VerifyPasswordResetOtpResponseModel.fromJson(errorData);
    } catch (e) {
      return VerifyPasswordResetOtpResponseModel(
        success: false,
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
        resetToken: '',
      );
    }
  }

  @override
  Future<ResetPasswordResponseModel> resetPassword(ResetPasswordRequestModel request) async {
    try {
      final response = await dioService.post(
        ApiEndpoints.resetPassword,
        data: request.toJson(),
      );
      
      return ResetPasswordResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = DioService.handleError(e);
      return ResetPasswordResponseModel.fromJson(errorData);
    } catch (e) {
      return ResetPasswordResponseModel(
        success: false,
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      );
    }
  }
}
