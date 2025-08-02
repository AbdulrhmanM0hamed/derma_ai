class RegisterRequestModel {
  final String email;
  final String phone;
  final String password;
  final String fullName;

  RegisterRequestModel({
    required this.email,
    required this.phone,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'full_name': fullName,
    };
  }
}
