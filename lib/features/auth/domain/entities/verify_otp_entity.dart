import 'package:equatable/equatable.dart';

class VerifyOtpEntity extends Equatable {
  final bool success;
  final String messageEn;
  final String messageAr;

  const VerifyOtpEntity({
    required this.success,
    required this.messageEn,
    required this.messageAr,
  });

  @override
  List<Object?> get props => [success, messageEn, messageAr];
}
