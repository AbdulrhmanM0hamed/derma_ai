import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool success;
  final String messageEn;
  final String messageAr;
  final String? token;
  final int? userId;
  final String? userType;

  const LoginEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.token,
    this.userId,
    this.userType,
  });

  @override
  List<Object?> get props => [
        success,
        messageEn,
        messageAr,
        token,
        userId,
        userType,
      ];
}
