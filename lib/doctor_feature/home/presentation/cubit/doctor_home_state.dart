part of 'doctor_home_cubit.dart';

sealed class DoctorHomeState extends Equatable {
  const DoctorHomeState();

  @override
  List<Object> get props => [];
}

// Initial State
final class DoctorHomeInitial extends DoctorHomeState {}

// Loading State
final class DoctorHomeLoading extends DoctorHomeState {}

// Loaded State
final class DoctorHomeLoaded extends DoctorHomeState {
  final HomeDoctorModel profile;

  const DoctorHomeLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

// Error State
final class DoctorHomeError extends DoctorHomeState {
  final String message;

  const DoctorHomeError(this.message);

  @override
  List<Object> get props => [message];
}
