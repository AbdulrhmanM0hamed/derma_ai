import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/register_entity.dart';
import '../entities/verify_otp_entity.dart';

abstract class AuthRepository {
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
}
