import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResendOtpUsecase implements UseCase<Map<String, dynamic>, ResendOtpParams> {
  final AuthRepository repository;

  ResendOtpUsecase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(ResendOtpParams params) async {
    return await repository.resendOtp(
      userId: params.userId,
      type: params.type,
    );
  }
}

class ResendOtpParams extends Equatable {
  final int userId;
  final String type;

  const ResendOtpParams({
    required this.userId,
    required this.type,
  });

  @override
  List<Object> get props => [userId, type];
}
