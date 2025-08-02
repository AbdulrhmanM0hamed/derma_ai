import 'package:equatable/equatable.dart';

class RegisterResponseModel extends Equatable {
  final bool success;
  final String messageEn;
  final String messageAr;
  final int? userId;
  final int? profileId;
  final String? uuid;
  final RequiresVerification? requiresVerification;

  RegisterResponseModel({
    required this.success,
    required this.messageEn,
    required this.messageAr,
    this.userId,
    this.profileId,
    this.uuid,
    this.requiresVerification,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? false,
      messageEn: json['message_en'] ?? '',
      messageAr: json['message_ar'] ?? '',
      userId: json['userId'],
      profileId: json['profileId'],
      uuid: json['uuid'],
      requiresVerification: json['requiresVerification'] != null
          ? RequiresVerification.fromJson(json['requiresVerification'])
          : null,
    );
  }

  @override
  List<Object?> get props => [success, messageEn, messageAr, userId, profileId, uuid, requiresVerification];
}

class RequiresVerification {
  final bool email;
  final bool phone;

  RequiresVerification({
    required this.email,
    required this.phone,
  });

  factory RequiresVerification.fromJson(Map<String, dynamic> json) {
    return RequiresVerification(
      email: json['email'] ?? false,
      phone: json['phone'] ?? false,
    );
  }
}
