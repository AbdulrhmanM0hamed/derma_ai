import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constant/api_endpoints.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRepository {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(Map<String, dynamic> data);
  Future<UserProfileModel> uploadProfilePicture(String filePath);
  Future<UserProfileModel> deleteProfilePicture();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<UserProfileModel> getUserProfile() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        ApiEndpoints.profileBasic,
        fromJson: (data) => data,
      );

      final responseModel = UserProfileResponse.fromJson(response);
      return responseModel.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfileModel> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.put<Map<String, dynamic>>(
        ApiEndpoints.profileBasic,
        data: data,
        fromJson: (data) => data,
      );

      final responseModel = UserProfileResponse.fromJson(response);
      return responseModel.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfileModel> uploadProfilePicture(String filePath) async {
    try {
      // Upload the picture
      await _apiService.postMultipart<Map<String, dynamic>>(
        ApiEndpoints.profilePicture,
        files: {'profile_picture': filePath},
        fromJson: (data) => data,
      );

      // API returns only profile_picture_url, so we need to fetch full profile
      final profileResponse = await _apiService.get<Map<String, dynamic>>(
        ApiEndpoints.profileBasic,
        fromJson: (data) => data,
      );
      
      final profileModel = UserProfileResponse.fromJson(profileResponse);
      return profileModel.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfileModel> deleteProfilePicture() async {
    try {
      // Delete the picture
      await _apiService.delete<Map<String, dynamic>>(
        ApiEndpoints.profilePicture,
        fromJson: (data) => data,
      );

      // Fetch updated profile
      final profileResponse = await _apiService.get<Map<String, dynamic>>(
        ApiEndpoints.profileBasic,
        fromJson: (data) => data,
      );
      
      final profileModel = UserProfileResponse.fromJson(profileResponse);
      return profileModel.data;
    } catch (e) {
      rethrow;
    }
  }
}
