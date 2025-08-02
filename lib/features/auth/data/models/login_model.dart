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
  final String? token;
  final int? userId;
  final String? userType;

  const LoginResponseModel({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.token,
    this.userId,
    this.userType,
  });

  @override
  List<Object?> get props => [success, messageEn, messageAr, token, userId, userType];

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
      token: json['token'],
      userId: json['user_id'],
      userType: json['user_type'],
    );
  }
}
