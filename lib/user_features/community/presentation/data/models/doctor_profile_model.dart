class DoctorProfileModel {
  final String id;
  final String name;
  final String specialization;
  final String avatar;
  final bool isVerified;
  final int yearsOfExperience;
  final double rating;
  final int followers;

  DoctorProfileModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.avatar,
    required this.isVerified,
    required this.yearsOfExperience,
    required this.rating,
    required this.followers,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      avatar: json['avatar'] ?? '',
      isVerified: json['isVerified'] ?? false,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      followers: json['followers'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'avatar': avatar,
      'isVerified': isVerified,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'followers': followers,
    };
  }
}
