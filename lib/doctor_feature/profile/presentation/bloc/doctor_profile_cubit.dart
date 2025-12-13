import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/doctor_profile_model.dart';
import '../../data/repositories/doctor_profile_repository.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository _repository;
  
  DoctorProfileModel? _currentProfile;

  DoctorProfileCubit(this._repository) : super(DoctorProfileInitial());

  // Getters
  DoctorProfileModel? get currentProfile => _currentProfile;

  // Get Doctor Profile
  Future<void> getDoctorProfile() async {
    try {
      emit(DoctorProfileLoading());
      
      final profile = await _repository.getDoctorProfile();
      _currentProfile = profile;
      
      emit(DoctorProfileLoaded(profile));
    } catch (e) {
      emit(DoctorProfileError(e.toString()));
    }
  }

  // Refresh Profile
  Future<void> refreshProfile() async {
    await getDoctorProfile();
  }

  // Update Doctor Profile
  Future<void> updateDoctorProfile(Map<String, dynamic> data) async {
    if (_currentProfile == null) {
      emit(const DoctorProfileError('No profile data available'));
      return;
    }

    try {
      emit(DoctorProfileUpdating(_currentProfile!));
      
      final updatedProfile = await _repository.updateDoctorProfile(data);
      _currentProfile = updatedProfile;
      
      emit(DoctorProfileUpdateSuccess(updatedProfile));
      
      await Future.delayed(const Duration(milliseconds: 100));
      emit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      emit(DoctorProfileUpdateError(e.toString(), _currentProfile!));
    }
  }

  // Upload Profile Picture
  Future<void> uploadProfilePicture(String filePath) async {
    if (_currentProfile == null) {
      emit(const DoctorProfileError('No profile data available'));
      return;
    }

    try {
      emit(DoctorProfileUpdating(_currentProfile!));
      
      final updatedProfile = await _repository.uploadProfilePicture(filePath);
      _currentProfile = updatedProfile;
      
      emit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      emit(DoctorProfileUpdateError(e.toString(), _currentProfile!));
      emit(DoctorProfileLoaded(_currentProfile!));
    }
  }

  // Delete Profile Picture
  Future<void> deleteProfilePicture() async {
    if (_currentProfile == null) {
      emit(const DoctorProfileError('No profile data available'));
      return;
    }

    try {
      emit(DoctorProfileUpdating(_currentProfile!));
      
      final updatedProfile = await _repository.deleteProfilePicture();
      _currentProfile = updatedProfile;
      
      emit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      emit(DoctorProfileUpdateError(e.toString(), _currentProfile!));
      emit(DoctorProfileLoaded(_currentProfile!));
    }
  }

  // Reset State
  void reset() {
    _currentProfile = null;
    emit(DoctorProfileInitial());
  }
}
