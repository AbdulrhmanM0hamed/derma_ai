import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponseModel extends Equatable {
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

  const LoginResponseModel({
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

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    final tokens = json['tokens'] as Map<String, dynamic>?;

    return LoginResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
      accessToken: tokens?['accessToken'],
      refreshToken: tokens?['refreshToken'],
      sessionToken: tokens?['sessionToken'],
      userId: user?['id'],
      userUuid: user?['uuid'],
      userEmail: user?['email'],
      userStatus: user?['status'],
    );
  }
}
