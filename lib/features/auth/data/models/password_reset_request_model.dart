class PasswordResetRequestModel {
  final String email;
  final String type;

  PasswordResetRequestModel({
    required this.email,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'type': type,
    };
  }
}
