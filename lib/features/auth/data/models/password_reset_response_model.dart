class PasswordResetResponseModel {
  final bool success;
  final String messageEn;
  final String messageAr;

  PasswordResetResponseModel({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
    );
  }
}
