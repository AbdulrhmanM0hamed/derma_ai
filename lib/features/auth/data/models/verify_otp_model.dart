class VerifyOtpRequestModel {
  final int userId;
  final String otp;
  final String type;

  VerifyOtpRequestModel({
    required this.userId,
    required this.otp,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'otp': otp,
      'type': type,
    };
  }
}

class VerifyOtpResponseModel {
  final bool success;
  final String messageEn;
  final String messageAr;

  VerifyOtpResponseModel({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
    );
  }
}
