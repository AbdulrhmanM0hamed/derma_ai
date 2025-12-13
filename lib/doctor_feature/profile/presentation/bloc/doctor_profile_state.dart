import 'package:equatable/equatable.dart';
import '../../data/models/doctor_profile_model.dart';

abstract class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object?> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileModel profile;

  const DoctorProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class DoctorProfileError extends DoctorProfileState {
  final String message;

  const DoctorProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class DoctorProfileUpdating extends DoctorProfileState {
  final DoctorProfileModel currentProfile;

  const DoctorProfileUpdating(this.currentProfile);

  @override
  List<Object?> get props => [currentProfile];
}

class DoctorProfileUpdateSuccess extends DoctorProfileState {
  final DoctorProfileModel profile;

  const DoctorProfileUpdateSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class DoctorProfileUpdateError extends DoctorProfileState {
  final String message;
  final DoctorProfileModel currentProfile;

  const DoctorProfileUpdateError(this.message, this.currentProfile);

  @override
  List<Object?> get props => [message, currentProfile];
}
