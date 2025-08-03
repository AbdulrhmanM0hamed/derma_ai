import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/password_reset_entity.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordResetOtpParams {
  final String email;
  final String type;

  RequestPasswordResetOtpParams({
    required this.email,
    required this.type,
  });
}

class RequestPasswordResetOtpUsecase {
  final AuthRepository repository;

  RequestPasswordResetOtpUsecase(this.repository);

  Future<Either<Failure, PasswordResetEntity>> call(RequestPasswordResetOtpParams params) async {
    return await repository.requestPasswordResetOtp(
      email: params.email,
      type: params.type,
    );
  }
}
