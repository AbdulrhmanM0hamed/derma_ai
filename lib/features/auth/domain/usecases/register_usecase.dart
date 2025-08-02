import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/register_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase implements UseCase<RegisterEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      phone: params.phone,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String phone;
  final String password;
  final String fullName;

  const RegisterParams({
    required this.email,
    required this.phone,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object> get props => [email, phone, password, fullName];
}
