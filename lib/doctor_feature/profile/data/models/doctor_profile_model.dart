import 'package:equatable/equatable.dart';

class DoctorProfileModel extends Equatable {
  final int id;
  final int doctorId;
  final String? licenseNumber;
  final String? profilePictureUrl;
  final int yearsOfExperience;
  final String? medicalSchool;
  final int? graduationYear;
  final String? boardCertifications;
  final String? languagesSpoken;
  final bool isVerified;
  final DateTime? verificationDate;
  final String? verifiedBy;
  final String approvalStatus;
  final double ratingAverage;
  final int ratingCount;
  final int totalConsultations;
  final bool isAvailable;
  final DateTime? nextAvailableSlot;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? emergencyContactPhone;
  final String timezone;
  final String languagePreference;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fullName;
  final String? specialty;
  final String? subSpecialty;
  final String? biography;
  final String? emergencyContactName;
  final String? emergencyContactRelationship;
  final String? languageCode;

  const DoctorProfileModel({
    required this.id,
    required this.doctorId,
    this.licenseNumber,
    this.profilePictureUrl,
    required this.yearsOfExperience,
    this.medicalSchool,
    this.graduationYear,
    this.boardCertifications,
    this.languagesSpoken,
    required this.isVerified,
    this.verificationDate,
    this.verifiedBy,
    required this.approvalStatus,
    required this.ratingAverage,
    required this.ratingCount,
    required this.totalConsultations,
    required this.isAvailable,
    this.nextAvailableSlot,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.emergencyContactPhone,
    required this.timezone,
    required this.languagePreference,
    required this.createdAt,
    required this.updatedAt,
    required this.fullName,
    this.specialty,
    this.subSpecialty,
    this.biography,
    this.emergencyContactName,
    this.emergencyContactRelationship,
    this.languageCode,
  });

  // Helper getters
  String get displayName => fullName.isNotEmpty ? fullName : 'Doctor';
  String get displaySpecialty => specialty ?? 'General Practitioner';
  String get displayExperience => '$yearsOfExperience';
  String get displayRating => ratingAverage.toStringAsFixed(1);
  bool get isPending => approvalStatus == 'pending';
  bool get isApproved => approvalStatus == 'approved';
  bool get isRejected => approvalStatus == 'rejected';

  DoctorProfileModel copyWith({
    int? id,
    int? doctorId,
    String? licenseNumber,
    String? profilePictureUrl,
    int? yearsOfExperience,
    String? medicalSchool,
    int? graduationYear,
    String? boardCertifications,
    String? languagesSpoken,
    bool? isVerified,
    DateTime? verificationDate,
    String? verifiedBy,
    String? approvalStatus,
    double? ratingAverage,
    int? ratingCount,
    int? totalConsultations,
    bool? isAvailable,
    DateTime? nextAvailableSlot,
    DateTime? dateOfBirth,
    String? gender,
    String? nationality,
    String? emergencyContactPhone,
    String? timezone,
    String? languagePreference,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullName,
    String? specialty,
    String? subSpecialty,
    String? biography,
    String? emergencyContactName,
    String? emergencyContactRelationship,
    String? languageCode,
  }) {
    return DoctorProfileModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      medicalSchool: medicalSchool ?? this.medicalSchool,
      graduationYear: graduationYear ?? this.graduationYear,
      boardCertifications: boardCertifications ?? this.boardCertifications,
      languagesSpoken: languagesSpoken ?? this.languagesSpoken,
      isVerified: isVerified ?? this.isVerified,
      verificationDate: verificationDate ?? this.verificationDate,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      ratingAverage: ratingAverage ?? this.ratingAverage,
      ratingCount: ratingCount ?? this.ratingCount,
      totalConsultations: totalConsultations ?? this.totalConsultations,
      isAvailable: isAvailable ?? this.isAvailable,
      nextAvailableSlot: nextAvailableSlot ?? this.nextAvailableSlot,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      timezone: timezone ?? this.timezone,
      languagePreference: languagePreference ?? this.languagePreference,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fullName: fullName ?? this.fullName,
      specialty: specialty ?? this.specialty,
      subSpecialty: subSpecialty ?? this.subSpecialty,
      biography: biography ?? this.biography,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactRelationship:
          emergencyContactRelationship ?? this.emergencyContactRelationship,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: json['id'] as int,
      doctorId: json['doctor_id'] as int,
      licenseNumber: json['license_number'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      yearsOfExperience: json['years_of_experience'] as int? ?? 0,
      medicalSchool: json['medical_school'] as String?,
      graduationYear: json['graduation_year'] as int?,
      boardCertifications: json['board_certifications'] as String?,
      languagesSpoken: json['languages_spoken'] as String?,
      isVerified: (json['is_verified'] as int? ?? 0) == 1,
      verificationDate:
          json['verification_date'] != null
              ? DateTime.parse(json['verification_date'] as String)
              : null,
      verifiedBy: json['verified_by'] as String?,
      approvalStatus: json['approval_status'] as String? ?? 'pending',
      ratingAverage:
          double.tryParse(json['rating_average']?.toString() ?? '0') ?? 0.0,
      ratingCount: json['rating_count'] as int? ?? 0,
      totalConsultations: json['total_consultations'] as int? ?? 0,
      isAvailable: (json['is_available'] as int? ?? 0) == 1,
      nextAvailableSlot:
          json['next_available_slot'] != null
              ? DateTime.parse(json['next_available_slot'] as String)
              : null,
      dateOfBirth:
          json['date_of_birth'] != null
              ? DateTime.parse(json['date_of_birth'] as String)
              : null,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      timezone: json['timezone'] as String? ?? 'UTC',
      languagePreference: json['language_preference'] as String? ?? 'ar',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      fullName: json['full_name'] as String? ?? '',
      specialty: json['specialty'] as String?,
      subSpecialty: json['sub_specialty'] as String?,
      biography: json['biography'] as String?,
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactRelationship:
          json['emergency_contact_relationship'] as String?,
      languageCode: json['language_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'license_number': licenseNumber,
      'profile_picture_url': profilePictureUrl,
      'years_of_experience': yearsOfExperience,
      'medical_school': medicalSchool,
      'graduation_year': graduationYear,
      'board_certifications': boardCertifications,
      'languages_spoken': languagesSpoken,
      'is_verified': isVerified ? 1 : 0,
      'verification_date': verificationDate?.toIso8601String(),
      'verified_by': verifiedBy,
      'approval_status': approvalStatus,
      'rating_average': ratingAverage.toString(),
      'rating_count': ratingCount,
      'total_consultations': totalConsultations,
      'is_available': isAvailable ? 1 : 0,
      'next_available_slot': nextAvailableSlot?.toIso8601String(),
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'nationality': nationality,
      'emergency_contact_phone': emergencyContactPhone,
      'timezone': timezone,
      'language_preference': languagePreference,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'full_name': fullName,
      'specialty': specialty,
      'sub_specialty': subSpecialty,
      'biography': biography,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_relationship': emergencyContactRelationship,
      'language_code': languageCode,
    };
  }

  @override
  List<Object?> get props => [
    id,
    doctorId,
    licenseNumber,
    profilePictureUrl,
    yearsOfExperience,
    medicalSchool,
    graduationYear,
    boardCertifications,
    languagesSpoken,
    isVerified,
    verificationDate,
    verifiedBy,
    approvalStatus,
    ratingAverage,
    ratingCount,
    totalConsultations,
    isAvailable,
    nextAvailableSlot,
    dateOfBirth,
    gender,
    nationality,
    emergencyContactPhone,
    timezone,
    languagePreference,
    createdAt,
    updatedAt,
    fullName,
    specialty,
    subSpecialty,
    biography,
    emergencyContactName,
    emergencyContactRelationship,
    languageCode,
  ];
}
