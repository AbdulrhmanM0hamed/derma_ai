import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;
  
  UserProfileModel? _currentProfile;

  ProfileCubit(this._repository) : super(ProfileInitial());

  // Get User Profile
  Future<void> getUserProfile() async {
    try {
      emit(ProfileLoading());
      
      final profile = await _repository.getUserProfile();
      _currentProfile = profile;
      
      emit(ProfileSuccess(profile));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  // Refresh Profile
  Future<void> refreshProfile() async {
    await getUserProfile();
  }

  // Update User Profile
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    //print('🟢 [ProfileCubit] updateUserProfile called - Cubit: ${hashCode}');
    //print('🟢 [ProfileCubit] Update data: $data');
    
    if (_currentProfile == null) {
      //print('🔴 [ProfileCubit] ERROR: _currentProfile is null!');
      emit(const ProfileFailure('No profile data available'));
      return;
    }

    try {
      //print('🟢 [ProfileCubit] Emitting ProfileUpdating...');
      emit(ProfileUpdating(_currentProfile!));
      
      //print('🟢 [ProfileCubit] Calling repository.updateUserProfile...');
      final updatedProfile = await _repository.updateUserProfile(data);
      _currentProfile = updatedProfile;
      
      //print('🟢 [ProfileCubit] Update successful! New phone: ${updatedProfile.phone}');
      //print('🟢 [ProfileCubit] Emitting ProfileUpdateSuccess...');
      emit(ProfileUpdateSuccess(updatedProfile));
      
      // Wait a bit then emit ProfileSuccess so the UI shows the updated data
      await Future.delayed(const Duration(milliseconds: 100));
      //print('🟢 [ProfileCubit] Emitting ProfileSuccess with updated data...');
      emit(ProfileSuccess(updatedProfile));
      //print('🟢 [ProfileCubit] ✅ Update flow completed!');
    } catch (e) {
      //print('🔴 [ProfileCubit] ERROR during update: $e');
      emit(ProfileUpdateFailure(e.toString(), _currentProfile!));
    }
  }

  // Upload Profile Picture
  Future<void> uploadProfilePicture(String filePath) async {
    //print('🟢 [ProfileCubit] uploadProfilePicture called - File: $filePath');
    
    if (_currentProfile == null) {
      //print('🔴 [ProfileCubit] ERROR: _currentProfile is null!');
      emit(const ProfileFailure('No profile data available'));
      return;
    }

    try {
      //print('🟢 [ProfileCubit] Emitting ProfileUpdating...');
      emit(ProfileUpdating(_currentProfile!));
      
      //print('🟢 [ProfileCubit] Calling repository.uploadProfilePicture...');
      final updatedProfile = await _repository.uploadProfilePicture(filePath);
      _currentProfile = updatedProfile;
      
      //print('🟢 [ProfileCubit] Upload successful! Picture URL: ${updatedProfile.profilePictureUrl}');
      //print('🟢 [ProfileCubit] Emitting ProfileSuccess with updated picture...');
      emit(ProfileSuccess(updatedProfile));
      //print('🟢 [ProfileCubit] ✅ Picture upload completed!');
    } catch (e) {
      //print('🔴 [ProfileCubit] ERROR during picture upload: $e');
      emit(ProfileUpdateFailure(e.toString(), _currentProfile!));
      // Re-emit current profile to restore UI
      emit(ProfileSuccess(_currentProfile!));
    }
  }

  // Delete Profile Picture
  Future<void> deleteProfilePicture() async {
    //print('🟢 [ProfileCubit] deleteProfilePicture called');
    
    if (_currentProfile == null) {
      //print('🔴 [ProfileCubit] ERROR: _currentProfile is null!');
      emit(const ProfileFailure('No profile data available'));
      return;
    }

    try {
      //print('🟢 [ProfileCubit] Emitting ProfileUpdating...');
      emit(ProfileUpdating(_currentProfile!));
      
      //print('🟢 [ProfileCubit] Calling repository.deleteProfilePicture...');
      final updatedProfile = await _repository.deleteProfilePicture();
      _currentProfile = updatedProfile;
      
      //print('🟢 [ProfileCubit] Delete successful! Picture removed');
      //print('🟢 [ProfileCubit] Emitting ProfileSuccess...');
      emit(ProfileSuccess(updatedProfile));
      //print('🟢 [ProfileCubit] ✅ Picture delete completed!');
    } catch (e) {
      //print('🔴 [ProfileCubit] ERROR during picture delete: $e');
      emit(ProfileUpdateFailure(e.toString(), _currentProfile!));
      // Re-emit current profile to restore UI
      emit(ProfileSuccess(_currentProfile!));
    }
  }

  // Reset State
  void reset() {
    _currentProfile = null;
    emit(ProfileInitial());
  }

  // Getters
  UserProfileModel? get currentProfile => _currentProfile;
}
