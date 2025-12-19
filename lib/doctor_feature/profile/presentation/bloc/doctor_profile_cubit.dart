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

  // Safe emit - only emit if cubit is not closed
  void _safeEmit(DoctorProfileState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  // Get Doctor Profile
  Future<void> getDoctorProfile() async {
    try {
      _safeEmit(DoctorProfileLoading());
      
      final profile = await _repository.getDoctorProfile();
      _currentProfile = profile;
      
      _safeEmit(DoctorProfileLoaded(profile));
    } catch (e) {
      _safeEmit(DoctorProfileError(e.toString()));
    }
  }

  // Refresh Profile
  Future<void> refreshProfile() async {
    await getDoctorProfile();
  }

  // Update Doctor Profile
  Future<void> updateDoctorProfile(Map<String, dynamic> data) async {
    if (_currentProfile == null) {
      _safeEmit(const DoctorProfileError('No profile data available'));
      return;
    }

    try {
      _safeEmit(DoctorProfileUpdating(_currentProfile!));
      
      final updatedProfile = await _repository.updateDoctorProfile(data);
      _currentProfile = updatedProfile;
      
      _safeEmit(DoctorProfileUpdateSuccess(updatedProfile));
      
      await Future.delayed(const Duration(milliseconds: 100));
      _safeEmit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      _safeEmit(DoctorProfileUpdateError(e.toString(), _currentProfile!));
    }
  }

  // Upload Profile Picture
  Future<void> uploadProfilePicture(String filePath) async {
    if (_currentProfile == null) {
      _safeEmit(const DoctorProfileError('No profile data available'));
      return;
    }

    try {
      _safeEmit(DoctorProfileUpdating(_currentProfile!));
      
      final updatedProfile = await _repository.uploadProfilePicture(filePath);
      _currentProfile = updatedProfile;
      
      _safeEmit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      _safeEmit(DoctorProfileUpdateError(e.toString(), _currentProfile!));
      _safeEmit(DoctorProfileLoaded(_currentProfile!));
    }
  }

  // Delete Profile Picture
  Future<void> deleteProfilePicture() async {
    if (_currentProfile == null) {
      _safeEmit(const DoctorProfileError('No profile data available'));
      return;
    }

    try {
      _safeEmit(DoctorProfileUpdating(_currentProfile!));
      
      final updatedProfile = await _repository.deleteProfilePicture();
      _currentProfile = updatedProfile;
      
      _safeEmit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      _safeEmit(DoctorProfileUpdateError(e.toString(), _currentProfile!));
      _safeEmit(DoctorProfileLoaded(_currentProfile!));
    }
  }

  // Reset State
  void reset() {
    _currentProfile = null;
    _safeEmit(DoctorProfileInitial());
  }
}
