import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final int id;
  final String uuid;
  final String email;
  final String phone;
  final String status;
  final int isActive;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? profilePictureUrl;
  final String? emergencyContactPhone;
  final String timezone;
  final String languagePreference;
  final String fullName;
  final String? emergencyContactName;
  final String? emergencyContactRelationship;

  const UserProfileModel({
    required this.id,
    required this.uuid,
    required this.email,
    required this.phone,
    required this.status,
    required this.isActive,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.profilePictureUrl,
    this.emergencyContactPhone,
    required this.timezone,
    required this.languagePreference,
    required this.fullName,
    this.emergencyContactName,
    this.emergencyContactRelationship,
  });

  // Helper getters for UI
  String get displayName => fullName.isNotEmpty ? fullName : 'مستخدم';
  String get patientId => 'BSH-${id.toString().padLeft(4, '0')}';
  bool get isVerified => status == 'verified';
  bool get isPendingVerification => status == 'pending_verification';
  
  // Location helper - could be enhanced with actual location data
  String get location => nationality ?? 'غير محدد';

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      status: (json['status'] as String?) ?? 'active',
      isActive: (json['is_active'] as int?) ?? 1,
      dateOfBirth: json['date_of_birth'] != null 
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      timezone: (json['timezone'] as String?) ?? 'UTC',
      languagePreference: (json['language_preference'] as String?) ?? 'ar',
      fullName: (json['full_name'] as String?) ?? '',
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactRelationship: json['emergency_contact_relationship'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'email': email,
      'phone': phone,
      'status': status,
      'is_active': isActive,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'nationality': nationality,
      'profile_picture_url': profilePictureUrl,
      'emergency_contact_phone': emergencyContactPhone,
      'timezone': timezone,
      'language_preference': languagePreference,
      'full_name': fullName,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_relationship': emergencyContactRelationship,
    };
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        email,
        phone,
        status,
        isActive,
        dateOfBirth,
        gender,
        nationality,
        profilePictureUrl,
        emergencyContactPhone,
        timezone,
        languagePreference,
        fullName,
        emergencyContactName,
        emergencyContactRelationship,
      ];
}

class UserProfileResponse extends Equatable {
  final bool success;
  final String message;
  final UserProfileModel data;

  const UserProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: UserProfileModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}
