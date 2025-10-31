import 'package:equatable/equatable.dart';

import '../../data/models/auth_models.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final UserModel entity;
  final String messageEn;
  final String messageAr;

  const LoginSuccess({
    required this.entity,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [entity, messageEn, messageAr];
}

class LoginFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const LoginFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class AccountNotVerified extends AuthState {
  final int userId;
  final String messageEn;
  final String messageAr;
  final Map<String, bool>? requiresVerification;

  const AccountNotVerified({
    required this.userId,
    required this.messageEn,
    required this.messageAr,
    this.requiresVerification,
  });

  @override
  List<Object?> get props => [userId, messageEn, messageAr, requiresVerification];
}

class RegisterSuccess extends AuthState {
  final UserModel entity;
  final String messageEn;
  final String messageAr;

  const RegisterSuccess({
    required this.entity,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [entity, messageEn, messageAr];
}

class RegisterFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const RegisterFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class VerifyOtpSuccess extends AuthState {
  final UserModel entity;
  final String messageEn;
  final String messageAr;

  const VerifyOtpSuccess({
    required this.entity,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [entity, messageEn, messageAr];
}

class VerifyOtpFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const VerifyOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class ResendOtpSuccess extends AuthState {
  final String messageEn;
  final String messageAr;

  const ResendOtpSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class ResendOtpFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const ResendOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class LogoutSuccess extends AuthState {
  final String messageEn;
  final String messageAr;

  const LogoutSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class LogoutFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const LogoutFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

// Password Reset States
class RequestPasswordResetOtpSuccess extends AuthState {
  final String messageEn;
  final String messageAr;

  const RequestPasswordResetOtpSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class RequestPasswordResetOtpFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const RequestPasswordResetOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class VerifyPasswordResetOtpSuccess extends AuthState {
  final String messageEn;
  final String messageAr;
  final String resetToken;

  const VerifyPasswordResetOtpSuccess({
    required this.messageEn,
    required this.messageAr,
    required this.resetToken,
  });

  @override
  List<Object?> get props => [messageEn, messageAr, resetToken];
}

class VerifyPasswordResetOtpFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const VerifyPasswordResetOtpFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class ResetPasswordSuccess extends AuthState {
  final String messageEn;
  final String messageAr;

  const ResetPasswordSuccess({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class ResetPasswordFailure extends AuthState {
  final String messageEn;
  final String messageAr;

  const ResetPasswordFailure({
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}
