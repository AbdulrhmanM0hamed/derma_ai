import 'package:dio/dio.dart';

import '../../../../core/services/dio_service.dart';
import '../../../../core/utils/constant/api_endpoints.dart';
import '../models/login_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/verify_otp_model.dart';

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
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioService dioService;

  AuthRemoteDataSourceImpl({required this.dioService});

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
    return LoginResponseModel.fromJson(response.data);
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
}
