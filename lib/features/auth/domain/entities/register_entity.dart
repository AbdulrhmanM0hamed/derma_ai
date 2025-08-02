import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final bool success;
  final String messageEn;
  final String messageAr;
  final int? userId;
  final int? profileId;
  final String? uuid;
  final RequiresVerificationEntity? requiresVerification;

  const RegisterEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.userId,
    this.profileId,
    this.uuid,
    this.requiresVerification,
  });

  @override
  List<Object?> get props => [
        success,
        messageEn,
        messageAr,
        userId,
        profileId,
        uuid,
        requiresVerification,
      ];
}

class RequiresVerificationEntity extends Equatable {
  final bool email;
  final bool phone;

  const RequiresVerificationEntity({
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, phone];
}
