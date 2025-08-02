import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool success;
  final String messageEn;
  final String messageAr;
  final String? accessToken;
  final String? refreshToken;
  final String? sessionToken;
  final int? userId;
  final String? userUuid;
  final String? userEmail;
  final String? userStatus;

  const LoginEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.accessToken,
    this.refreshToken,
    this.sessionToken,
    this.userId,
    this.userUuid,
    this.userEmail,
    this.userStatus,
  });

  @override
  List<Object?> get props => [
        success,
        messageEn,
        messageAr,
        accessToken,
        refreshToken,
        sessionToken,
        userId,
        userUuid,
        userEmail,
        userStatus,
      ];
}
