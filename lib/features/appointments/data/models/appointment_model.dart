class AppointmentModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorPhoto;
  final String patientName;
  final String patientPhone;
  final String patientEmail;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String appointmentType;
  final String symptoms;
  final String additionalNotes;
  final AppointmentStatus status;
  final double consultationFee;
  final String clinicAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorPhoto,
    required this.patientName,
    required this.patientPhone,
    required this.patientEmail,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentType,
    required this.symptoms,
    required this.additionalNotes,
    required this.status,
    required this.consultationFee,
    required this.clinicAddress,
    required this.createdAt,
    this.updatedAt,
  });

  AppointmentModel copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? doctorSpecialty,
    String? doctorPhoto,
    String? patientName,
    String? patientPhone,
    String? patientEmail,
    DateTime? appointmentDate,
    String? appointmentTime,
    String? appointmentType,
    String? symptoms,
    String? additionalNotes,
    AppointmentStatus? status,
    double? consultationFee,
    String? clinicAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorPhoto: doctorPhoto ?? this.doctorPhoto,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      patientEmail: patientEmail ?? this.patientEmail,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentType: appointmentType ?? this.appointmentType,
      symptoms: symptoms ?? this.symptoms,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      status: status ?? this.status,
      consultationFee: consultationFee ?? this.consultationFee,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      'appointmentDate': appointmentDate.toIso8601String(),
      'appointmentTime': appointmentTime,
      'appointmentType': appointmentType,
      'symptoms': symptoms,
      'additionalNotes': additionalNotes,
      'status': status.name,
      'consultationFee': consultationFee,
      'clinicAddress': clinicAddress,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorSpecialty: json['doctorSpecialty'] ?? '',
      doctorPhoto: json['doctorPhoto'] ?? '',
      patientName: json['patientName'] ?? '',
      patientPhone: json['patientPhone'] ?? '',
      patientEmail: json['patientEmail'] ?? '',
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentTime: json['appointmentTime'] ?? '',
      appointmentType: json['appointmentType'] ?? '',
      symptoms: json['symptoms'] ?? '',
      additionalNotes: json['additionalNotes'] ?? '',
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      consultationFee: (json['consultationFee'] ?? 0.0).toDouble(),
      clinicAddress: json['clinicAddress'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }
}

enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
  rescheduled,
}

enum AppointmentType {
  consultation,
  followUp,
  emergency,
  checkup,
}

extension AppointmentStatusExtension on AppointmentStatus {
  String get arabicName {
    switch (this) {
      case AppointmentStatus.pending:
        return 'في الانتظار';
      case AppointmentStatus.confirmed:
        return 'مؤكد';
      case AppointmentStatus.cancelled:
        return 'ملغي';
      case AppointmentStatus.completed:
        return 'مكتمل';
      case AppointmentStatus.rescheduled:
        return 'معاد جدولته';
    }
  }

  String get description {
    switch (this) {
      case AppointmentStatus.pending:
        return 'الموعد في انتظار تأكيد الطبيب';
      case AppointmentStatus.confirmed:
        return 'تم تأكيد الموعد من قبل الطبيب';
      case AppointmentStatus.cancelled:
        return 'تم إلغاء الموعد';
      case AppointmentStatus.completed:
        return 'تم إنجاز الموعد بنجاح';
      case AppointmentStatus.rescheduled:
        return 'تم تغيير موعد الحجز';
    }
  }
}

extension AppointmentTypeExtension on AppointmentType {
  String get arabicName {
    switch (this) {
      case AppointmentType.consultation:
        return 'استشارة';
      case AppointmentType.followUp:
        return 'متابعة';
      case AppointmentType.emergency:
        return 'طارئ';
      case AppointmentType.checkup:
        return 'فحص دوري';
    }
  }

  String get description {
    switch (this) {
      case AppointmentType.consultation:
        return 'استشارة طبية عامة';
      case AppointmentType.followUp:
        return 'متابعة حالة سابقة';
      case AppointmentType.emergency:
        return 'حالة طارئة تحتاج عناية فورية';
      case AppointmentType.checkup:
        return 'فحص دوري للاطمئنان على الصحة';
    }
  }
}
