class ResetPasswordRequestModel {
  final String token;
  final String newPassword;

  ResetPasswordRequestModel({
    required this.token,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'newPassword': newPassword,
    };
  }
}

class ResetPasswordResponseModel {
  final bool success;
  final String messageEn;
  final String messageAr;

  ResetPasswordResponseModel({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
    );
  }
}
