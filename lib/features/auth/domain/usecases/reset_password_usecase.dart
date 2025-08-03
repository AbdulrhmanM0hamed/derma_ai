import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/password_reset_entity.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordParams {
  final String token;
  final String newPassword;

  ResetPasswordParams({
    required this.token,
    required this.newPassword,
  });
}

class ResetPasswordUsecase {
  final AuthRepository repository;

  ResetPasswordUsecase(this.repository);

  Future<Either<Failure, ResetPasswordEntity>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      token: params.token,
      newPassword: params.newPassword,
    );
  }
}
