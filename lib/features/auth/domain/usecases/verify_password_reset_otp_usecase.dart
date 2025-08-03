import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/password_reset_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyPasswordResetOtpParams {
  final String email;
  final String otp;

  VerifyPasswordResetOtpParams({
    required this.email,
    required this.otp,
  });
}

class VerifyPasswordResetOtpUsecase {
  final AuthRepository repository;

  VerifyPasswordResetOtpUsecase(this.repository);

  Future<Either<Failure, VerifyPasswordResetOtpEntity>> call(VerifyPasswordResetOtpParams params) async {
    return await repository.verifyPasswordResetOtp(
      email: params.email,
      otp: params.otp,
    );
  }
}
