class VerifyPasswordResetOtpRequestModel {
  final String email;
  final String otp;

  VerifyPasswordResetOtpRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}

class VerifyPasswordResetOtpResponseModel {
  final bool success;
  final String messageEn;
  final String messageAr;
  final String? resetToken;

  VerifyPasswordResetOtpResponseModel({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.resetToken,
  });

  factory VerifyPasswordResetOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyPasswordResetOtpResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
      resetToken: json['resetToken'],
    );
  }
}
