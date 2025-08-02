import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
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

  @override
  List<Object?> get props => [email, phone, password, fullName];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'full_name': fullName,
    };
  }
}
