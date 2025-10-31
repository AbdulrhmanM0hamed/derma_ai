class VideoCallPackageModel {
  final String id;
  final String name;
  final String description;
  final int durationMinutes;
  final double price;
  final List<String> features;
  final bool isPopular;
  final String? discountPercentage;
  final double? originalPrice;

  VideoCallPackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.price,
    required this.features,
    this.isPopular = false,
    this.discountPercentage,
    this.originalPrice,
  });

  VideoCallPackageModel copyWith({
    String? id,
    String? name,
    String? description,
    int? durationMinutes,
    double? price,
    List<String>? features,
    bool? isPopular,
    String? discountPercentage,
    double? originalPrice,
  }) {
    return VideoCallPackageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      price: price ?? this.price,
      features: features ?? this.features,
      isPopular: isPopular ?? this.isPopular,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'durationMinutes': durationMinutes,
      'price': price,
      'features': features,
      'isPopular': isPopular,
      'discountPercentage': discountPercentage,
      'originalPrice': originalPrice,
    };
  }

  factory VideoCallPackageModel.fromJson(Map<String, dynamic> json) {
    return VideoCallPackageModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      durationMinutes: json['durationMinutes'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      features: List<String>.from(json['features'] ?? []),
      isPopular: json['isPopular'] ?? false,
      discountPercentage: json['discountPercentage'],
      originalPrice: json['originalPrice']?.toDouble(),
    );
  }

  String get formattedDuration {
    if (durationMinutes < 60) {
      return '$durationMinutes دقيقة';
    } else {
      final hours = durationMinutes ~/ 60;
      final minutes = durationMinutes % 60;
      if (minutes == 0) {
        return '$hours ساعة';
      } else {
        return '$hours ساعة و $minutes دقيقة';
      }
    }
  }

  String get formattedPrice {
    return '${price.toStringAsFixed(0)} ريال';
  }

  String? get formattedOriginalPrice {
    return originalPrice != null ? '${originalPrice!.toStringAsFixed(0)} ريال' : null;
  }
}

class VideoCallBookingModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorPhoto;
  final String patientName;
  final String patientPhone;
  final String patientEmail;
  final DateTime scheduledDate;
  final String scheduledTime;
  final VideoCallPackageModel package;
  final String symptoms;
  final String additionalNotes;
  final VideoCallStatus status;
  final String? meetingLink;
  final String? meetingId;
  final String? meetingPassword;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? startedAt;
  final DateTime? endedAt;

  VideoCallBookingModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorPhoto,
    required this.patientName,
    required this.patientPhone,
    required this.patientEmail,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.package,
    required this.symptoms,
    required this.additionalNotes,
    required this.status,
    this.meetingLink,
    this.meetingId,
    this.meetingPassword,
    required this.createdAt,
    this.updatedAt,
    this.startedAt,
    this.endedAt,
  });

  VideoCallBookingModel copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? doctorSpecialty,
    String? doctorPhoto,
    String? patientName,
    String? patientPhone,
    String? patientEmail,
    DateTime? scheduledDate,
    String? scheduledTime,
    VideoCallPackageModel? package,
    String? symptoms,
    String? additionalNotes,
    VideoCallStatus? status,
    String? meetingLink,
    String? meetingId,
    String? meetingPassword,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    return VideoCallBookingModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorPhoto: doctorPhoto ?? this.doctorPhoto,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      patientEmail: patientEmail ?? this.patientEmail,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      package: package ?? this.package,
      symptoms: symptoms ?? this.symptoms,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      status: status ?? this.status,
      meetingLink: meetingLink ?? this.meetingLink,
      meetingId: meetingId ?? this.meetingId,
      meetingPassword: meetingPassword ?? this.meetingPassword,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'doctorPhoto': doctorPhoto,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientEmail': patientEmail,
      'scheduledDate': scheduledDate.toIso8601String(),
      'scheduledTime': scheduledTime,
      'package': package.toJson(),
      'symptoms': symptoms,
      'additionalNotes': additionalNotes,
      'status': status.name,
      'meetingLink': meetingLink,
      'meetingId': meetingId,
      'meetingPassword': meetingPassword,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
    };
  }

  factory VideoCallBookingModel.fromJson(Map<String, dynamic> json) {
    return VideoCallBookingModel(
      id: json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorSpecialty: json['doctorSpecialty'] ?? '',
      doctorPhoto: json['doctorPhoto'] ?? '',
      patientName: json['patientName'] ?? '',
      patientPhone: json['patientPhone'] ?? '',
      patientEmail: json['patientEmail'] ?? '',
      scheduledDate: DateTime.parse(json['scheduledDate']),
      scheduledTime: json['scheduledTime'] ?? '',
      package: VideoCallPackageModel.fromJson(json['package']),
      symptoms: json['symptoms'] ?? '',
      additionalNotes: json['additionalNotes'] ?? '',
      status: VideoCallStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => VideoCallStatus.scheduled,
      ),
      meetingLink: json['meetingLink'],
      meetingId: json['meetingId'],
      meetingPassword: json['meetingPassword'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
      endedAt: json['endedAt'] != null ? DateTime.parse(json['endedAt']) : null,
    );
  }
}

enum VideoCallStatus {
  scheduled,
  confirmed,
  inProgress,
  completed,
  cancelled,
  missed,
}

extension VideoCallStatusExtension on VideoCallStatus {
  String get arabicName {
    switch (this) {
      case VideoCallStatus.scheduled:
        return 'مجدولة';
      case VideoCallStatus.confirmed:
        return 'مؤكدة';
      case VideoCallStatus.inProgress:
        return 'جارية';
      case VideoCallStatus.completed:
        return 'مكتملة';
      case VideoCallStatus.cancelled:
        return 'ملغية';
      case VideoCallStatus.missed:
        return 'فائتة';
    }
  }

  String get description {
    switch (this) {
      case VideoCallStatus.scheduled:
        return 'المكالمة مجدولة في انتظار التأكيد';
      case VideoCallStatus.confirmed:
        return 'تم تأكيد المكالمة من قبل الطبيب';
      case VideoCallStatus.inProgress:
        return 'المكالمة جارية الآن';
      case VideoCallStatus.completed:
        return 'تم إنجاز المكالمة بنجاح';
      case VideoCallStatus.cancelled:
        return 'تم إلغاء المكالمة';
      case VideoCallStatus.missed:
        return 'لم يتم الرد على المكالمة';
    }
  }
}
