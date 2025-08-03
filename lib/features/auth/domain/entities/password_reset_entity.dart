class PasswordResetEntity {
  final bool success;
  final String messageEn;
  final String messageAr;

  PasswordResetEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });
}

class VerifyPasswordResetOtpEntity {
  final bool success;
  final String messageEn;
  final String messageAr;
  final String? resetToken;

  VerifyPasswordResetOtpEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.resetToken,
  });
}

class ResetPasswordEntity {
  final bool success;
  final String messageEn;
  final String messageAr;

  ResetPasswordEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });
}
