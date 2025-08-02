import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/verify_otp_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUsecase implements UseCase<VerifyOtpEntity, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUsecase(this.repository);

  @override
  Future<Either<Failure, VerifyOtpEntity>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(
      userId: params.userId,
      otp: params.otp,
      type: params.type,
    );
  }
}

class VerifyOtpParams extends Equatable {
  final int userId;
  final String otp;
  final String type;

  const VerifyOtpParams({
    required this.userId,
    required this.otp,
    required this.type,
  });

  @override
  List<Object> get props => [userId, otp, type];
}
