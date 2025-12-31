import 'package:equatable/equatable.dart';

// Home Doctor Model
class HomeDoctorModel extends Equatable {
  final int id;
  final int doctorId;
  final String fullName;
  final String? specialty;
  final String? subSpecialty;
  final String? profilePictureUrl;
  final int yearsOfExperience;
  final double ratingAverage;
  final int ratingCount;
  final int totalConsultations;
  final bool isAvailable;
  final bool isVerified;
  final String approvalStatus;

  const HomeDoctorModel({
    required this.id,
    required this.doctorId,
    required this.fullName,
    this.specialty,
    this.subSpecialty,
    this.profilePictureUrl,
    required this.yearsOfExperience,
    required this.ratingAverage,
    required this.ratingCount,
    required this.totalConsultations,
    required this.isAvailable,
    required this.isVerified,
    required this.approvalStatus,
  });

  // Helper getters
  String get displayName => fullName.isNotEmpty ? fullName : 'Doctor';
  String get displaySpecialty => specialty ?? 'General Practitioner';
  String get displayExperience => '$yearsOfExperience';
  String get displayRating => ratingAverage.toStringAsFixed(1);

  // From JSON
  factory HomeDoctorModel.fromJson(Map<String, dynamic> json) {
    return HomeDoctorModel(
      id: json['id'] as int,
      doctorId: json['doctor_id'] as int,
      fullName: json['full_name'] as String? ?? '',
      specialty: json['specialty'] as String?,
      subSpecialty: json['sub_specialty'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      yearsOfExperience: json['years_of_experience'] as int? ?? 0,
      ratingAverage:
          double.tryParse(json['rating_average']?.toString() ?? '0') ?? 0.0,
      ratingCount: json['rating_count'] as int? ?? 0,
      totalConsultations: json['total_consultations'] as int? ?? 0,
      isAvailable: (json['is_available'] as int? ?? 0) == 1,
      isVerified: (json['is_verified'] as int? ?? 0) == 1,
      approvalStatus: json['approval_status'] as String? ?? 'pending',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'full_name': fullName,
      'specialty': specialty,
      'sub_specialty': subSpecialty,
      'profile_picture_url': profilePictureUrl,
      'years_of_experience': yearsOfExperience,
      'rating_average': ratingAverage.toString(),
      'rating_count': ratingCount,
      'total_consultations': totalConsultations,
      'is_available': isAvailable ? 1 : 0,
      'is_verified': isVerified ? 1 : 0,
      'approval_status': approvalStatus,
    };
  }

  // Copy With
  HomeDoctorModel copyWith({
    int? id,
    int? doctorId,
    String? fullName,
    String? specialty,
    String? subSpecialty,
    String? profilePictureUrl,
    int? yearsOfExperience,
    double? ratingAverage,
    int? ratingCount,
    int? totalConsultations,
    bool? isAvailable,
    bool? isVerified,
    String? approvalStatus,
  }) {
    return HomeDoctorModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      fullName: fullName ?? this.fullName,
      specialty: specialty ?? this.specialty,
      subSpecialty: subSpecialty ?? this.subSpecialty,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      ratingAverage: ratingAverage ?? this.ratingAverage,
      ratingCount: ratingCount ?? this.ratingCount,
      totalConsultations: totalConsultations ?? this.totalConsultations,
      isAvailable: isAvailable ?? this.isAvailable,
      isVerified: isVerified ?? this.isVerified,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  @override
  List<Object?> get props => [
    id,
    doctorId,
    fullName,
    specialty,
    subSpecialty,
    profilePictureUrl,
    yearsOfExperience,
    ratingAverage,
    ratingCount,
    totalConsultations,
    isAvailable,
    isVerified,
    approvalStatus,
  ];
}
