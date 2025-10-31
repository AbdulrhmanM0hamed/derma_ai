abstract class DoctorAuthState {}

class DoctorAuthInitial extends DoctorAuthState {}

class DoctorAuthLoading extends DoctorAuthState {}

// Login States
class DoctorLoginSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  DoctorLoginSuccess({
    required this.messageEn,
    required this.messageAr,
  });
}

class DoctorLoginFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  DoctorLoginFailure({
    required this.messageEn,
    required this.messageAr,
  });
}

// Register States
class DoctorRegisterSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  DoctorRegisterSuccess({
    required this.messageEn,
    required this.messageAr,
  });
}

class DoctorRegisterFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  DoctorRegisterFailure({
    required this.messageEn,
    required this.messageAr,
  });
}

// Logout States
class DoctorLogoutSuccess extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  DoctorLogoutSuccess({
    required this.messageEn,
    required this.messageAr,
  });
}

class DoctorLogoutFailure extends DoctorAuthState {
  final String messageEn;
  final String messageAr;

  DoctorLogoutFailure({
    required this.messageEn,
    required this.messageAr,
  });
}

// Account Verification States
class DoctorAccountNotVerified extends DoctorAuthState {
  final int userId;
  final String messageEn;
  final String messageAr;
  final Map<String, dynamic>? requiresVerification;

  DoctorAccountNotVerified({
    required this.userId,
    required this.messageEn,
    required this.messageAr,
    this.requiresVerification,
  });
}
