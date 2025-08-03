import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_entity.dart';
import '../entities/register_entity.dart';
import '../entities/verify_otp_entity.dart';
import '../entities/password_reset_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, RegisterEntity>> register({
    required String email,
    required String phone,
    required String password,
    required String fullName,
  });

  Future<Either<Failure, VerifyOtpEntity>> verifyOtp({
    required int userId,
    required String otp,
    required String type,
  });

  Future<Either<Failure, Map<String, dynamic>>> resendOtp({
    required int userId,
    required String type,
  });

  Future<Either<Failure, void>> logout();

  // Password reset methods
  Future<Either<Failure, PasswordResetEntity>> requestPasswordResetOtp({
    required String email,
    required String type,
  });

  Future<Either<Failure, VerifyPasswordResetOtpEntity>> verifyPasswordResetOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, ResetPasswordEntity>> resetPassword({
    required String token,
    required String newPassword,
  });
}
