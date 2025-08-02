import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/verify_otp_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/register_request_model.dart';
import '../models/verify_otp_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(LoginEntity(
        success: response.success,
        messageEn: response.messageEn,
        messageAr: response.messageAr,
        token: response.token,
        userId: response.userId,
        userType: response.userType,
      ));
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.response?.data['message_en'] ?? 'Server error occurred',
        messageAr: e.response?.data['message_ar'] ?? 'حدث خطأ في الخادم',
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register({
    required String email,
    required String phone,
    required String password,
    required String fullName,
  }) async {
    try {
      final request = RegisterRequestModel(
        email: email,
        phone: phone,
        password: password,
        fullName: fullName,
      );

      final result = await remoteDataSource.register(request);

      if (result.success) {
        return Right(RegisterEntity(
          success: result.success,
          messageEn: result.messageEn,
          messageAr: result.messageAr,
          userId: result.userId,
          profileId: result.profileId,
          uuid: result.uuid,
          requiresVerification: result.requiresVerification != null
              ? RequiresVerificationEntity(
                  email: result.requiresVerification!.email,
                  phone: result.requiresVerification!.phone,
                )
              : null,
        ));
      } else {
        return Left(ServerFailure(
          message: result.messageEn,
          messageAr: result.messageAr,
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Server error occurred',
        messageAr: 'حدث خطأ في الخادم',
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpEntity>> verifyOtp({
    required int userId,
    required String otp,
    required String type,
  }) async {
    try {
      final request = VerifyOtpRequestModel(
        userId: userId,
        otp: otp,
        type: type,
      );

      final result = await remoteDataSource.verifyOtp(request);

      if (result.success) {
        return Right(VerifyOtpEntity(
          success: result.success,
          messageEn: result.messageEn,
          messageAr: result.messageAr,
        ));
      } else {
        return Left(ServerFailure(
          message: result.messageEn,
          messageAr: result.messageAr,
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Server error occurred',
        messageAr: 'حدث خطأ في الخادم',
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resendOtp({
    required int userId,
    required String type,
  }) async {
    try {
      final result = await remoteDataSource.resendOtp(
        userId: userId,
        type: type,
      );

      if (result['success'] == true) {
        return Right(result);
      } else {
        return Left(ServerFailure(
          message: result['message_en'] ?? 'Failed to resend OTP',
          messageAr: result['message_ar'] ?? 'فشل في إعادة إرسال الرمز',
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Server error occurred',
        messageAr: 'حدث خطأ في الخادم',
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }
}
