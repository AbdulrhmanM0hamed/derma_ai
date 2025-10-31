import 'package:equatable/equatable.dart';

import '../../../../user_features/auth/data/models/auth_models.dart';

abstract class DoctorAuthState extends Equatable {
  const DoctorAuthState();

  @override
  List<Object?> get props => [];
}

class DoctorAuthInitial extends DoctorAuthState {}

class DoctorAuthLoading extends DoctorAuthState {}

// Login States
class DoctorLoginSuccess extends DoctorAuthState {
  final UserModel entity;
  final String messageEn;
  final String messageAr;

  const DoctorLoginSuccess({
    required this.entity,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [entity, messageEn, messageAr];
}

class DoctorLoginFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorLoginFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

// Register States
class DoctorRegisterSuccess extends DoctorAuthState {
  final UserModel entity;
  final String messageEn;
  final String messageAr;

  const DoctorRegisterSuccess({
    required this.entity,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [entity, messageEn, messageAr];
}

class DoctorRegisterFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorRegisterFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

// Logout States
class DoctorLogoutSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorLogoutSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorLogoutFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorLogoutFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

// Account Verification States
class DoctorAccountNotVerified extends DoctorAuthState {
  final int userId;
  final String messageEn;
  final String messageAr;
  final Map<String, bool>? requiresVerification;

  const DoctorAccountNotVerified({
    required this.userId,
    required this.messageEn,
    required this.messageAr,
    this.requiresVerification,
  });

  @override
  List<Object?> get props => [userId, messageEn, messageAr, requiresVerification];
}

// OTP Verification States
class DoctorVerifyOtpSuccess extends DoctorAuthState {
  final UserModel entity;
  final String messageEn;
  final String messageAr;

  const DoctorVerifyOtpSuccess({
    required this.entity,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [entity, messageEn, messageAr];
}

class DoctorVerifyOtpFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorVerifyOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorResendOtpSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorResendOtpSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorResendOtpFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorResendOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

// Password Reset States
class DoctorRequestPasswordResetOtpSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorRequestPasswordResetOtpSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorRequestPasswordResetOtpFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorRequestPasswordResetOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorVerifyPasswordResetOtpSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;
  final String resetToken;

  const DoctorVerifyPasswordResetOtpSuccess({
    required this.messageEn,
    required this.messageAr,
    required this.resetToken,
  });

  @override
  List<Object?> get props => [messageEn, messageAr, resetToken];
}

class DoctorVerifyPasswordResetOtpFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorVerifyPasswordResetOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorResetPasswordSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorResetPasswordSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class DoctorResetPasswordFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  const DoctorResetPasswordFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}
