import 'package:equatable/equatable.dart';
import '../../data/models/user_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileModel userProfile;

  const ProfileSuccess(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Update Profile States
class ProfileUpdating extends ProfileState {
  final UserProfileModel currentProfile;

  const ProfileUpdating(this.currentProfile);

  @override
  List<Object?> get props => [currentProfile];
}

class ProfileUpdateSuccess extends ProfileState {
  final UserProfileModel userProfile;

  const ProfileUpdateSuccess(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class ProfileUpdateFailure extends ProfileState {
  final String message;
  final UserProfileModel currentProfile;

  const ProfileUpdateFailure(this.message, this.currentProfile);

  @override
  List<Object?> get props => [message, currentProfile];
}
