// Request Models
class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class SignupRequestModel {
  final String email;
  final String phone;
  final String password;
  final String fullName;
  final String? licenseNumber; // رقم ترخيص مزاولة المهنة للدكتور

  SignupRequestModel({
    required this.email,
    required this.phone,
    required this.password,
    required this.fullName,
    this.licenseNumber,
  });

  Map<String, dynamic> toJson() {
    final map = {
      'email': email,
      'phone': phone,
      'password': password,
      'full_name': fullName,
    };

    // Add license number only if provided (for doctors)
    if (licenseNumber != null && licenseNumber!.isNotEmpty) {
      map['license_number'] = licenseNumber!;
    }

    return map;
  }
}

class ForgetPasswordRequestModel {
  final String email;
  final String type;

  ForgetPasswordRequestModel({required this.email, required this.type});

  Map<String, dynamic> toJson() {
    return {'email': email, 'type': type};
  }
}

class CheckOtpRequestModel {
  final int userId;
  final String otp;
  final String type;

  CheckOtpRequestModel({
    required this.userId,
    required this.otp,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'otp': otp, 'type': type};
  }
}

class ChangePasswordRequestModel {
  final String token;
  final String newPassword;

  ChangePasswordRequestModel({required this.token, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {'token': token, 'new_password': newPassword};
  }
}

class ResendOtpRequestModel {
  final int userId;
  final String type;

  ResendOtpRequestModel({required this.userId, required this.type});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'type': type};
  }
}

class TokensModel {
  final String accessToken;
  final String refreshToken;
  final String sessionToken;

  TokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.sessionToken,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      sessionToken: json['sessionToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'sessionToken': sessionToken,
    };
  }
}

// Response Models
class LoginResponse {
  final bool success;
  final String messageEn;
  final String messageAr;
  final UserModel? user;
  final TokensModel? tokens;
  final bool? accountNotVerified;
  final int? userId;
  final Map<String, bool>? requiresVerification;

  LoginResponse({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.user,
    this.tokens,
    this.accountNotVerified,
    this.userId,
    this.requiresVerification,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? json['message'] ?? '',
      messageAr: json['message_ar'] ?? json['message'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      tokens:
          json['tokens'] != null ? TokensModel.fromJson(json['tokens']) : null,
      accountNotVerified: json['accountNotVerified'],
      userId: json['userId'],
      requiresVerification:
          json['requiresVerification'] != null
              ? Map<String, bool>.from(json['requiresVerification'])
              : null,
    );
  }
}

class RegisterResponse {
  final bool success;
  final String messageEn;
  final String messageAr;
  final UserModel? user;
  final int? userId;

  RegisterResponse({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.user,
    this.userId,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? json['message'] ?? '',
      messageAr: json['message_ar'] ?? json['message'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      userId: json['user_id'] ?? json['userId'],
    );
  }
}

class BaseResponse {
  final bool success;
  final String messageEn;
  final String messageAr;

  BaseResponse({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? json['message'] ?? '',
      messageAr: json['message_ar'] ?? json['message'] ?? '',
    );
  }
}

class RefreshTokenResponse {
  final int status;
  final String message;
  final String messageAr;
  final TokenData data;

  RefreshTokenResponse({
    required this.status,
    required this.message,
    required this.messageAr,
    required this.data,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      status: json['status'] ?? 200,
      message: json['message'] ?? json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? json['message'] ?? '',
      data: TokenData.fromJson(json['data'] ?? {}),
    );
  }
}

class TokenData {
  final String accessToken;
  final String refreshToken;

  TokenData({required this.accessToken, required this.refreshToken});

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}

class UserModel {
  final int id;
  final String uuid;
  final String email;
  final String? phone;
  final String status;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String? adminType;

  UserModel({
    required this.id,
    required this.uuid,
    required this.email,
    this.phone,
    required this.status,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.adminType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      status: json['status'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      phoneVerifiedAt: json['phone_verified_at'],
      adminType: json['adminType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'email': email,
      'phone': phone,
      'status': status,
      'email_verified_at': emailVerifiedAt,
      'phone_verified_at': phoneVerifiedAt,
      'adminType': adminType,
    };
  }
}
