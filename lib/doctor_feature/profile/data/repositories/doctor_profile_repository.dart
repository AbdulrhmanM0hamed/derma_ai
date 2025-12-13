import 'package:derma_ai/core/network/api_service.dart';
import 'package:derma_ai/core/utils/constant/api_endpoints.dart';
import '../models/doctor_profile_model.dart';

abstract class DoctorProfileRepository {
  Future<DoctorProfileModel> getDoctorProfile();
  Future<DoctorProfileModel> updateDoctorProfile(Map<String, dynamic> data);
  Future<DoctorProfileModel> uploadProfilePicture(String filePath);
  Future<DoctorProfileModel> deleteProfilePicture();
}

class DoctorProfileRepositoryImpl implements DoctorProfileRepository {
  final ApiService _apiService;

  DoctorProfileRepositoryImpl(this._apiService);

  @override
  Future<DoctorProfileModel> getDoctorProfile() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.doctorProfile,
    );

    if (response['success'] == true && response['data'] != null) {
      return DoctorProfileModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to load doctor profile');
  }

  @override
  Future<DoctorProfileModel> updateDoctorProfile(Map<String, dynamic> data) async {
    final response = await _apiService.put<Map<String, dynamic>>(
      ApiEndpoints.doctorProfile,
      data: data,
    );

    if (response['success'] == true && response['data'] != null) {
      return DoctorProfileModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to update doctor profile');
  }

  @override
  Future<DoctorProfileModel> uploadProfilePicture(String filePath) async {
    final response = await _apiService.postMultipart<Map<String, dynamic>>(
      ApiEndpoints.doctorProfilePicture,
      files: {'profile_picture': filePath},
    );

    if (response['success'] == true && response['data'] != null) {
      return DoctorProfileModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to upload profile picture');
  }

  @override
  Future<DoctorProfileModel> deleteProfilePicture() async {
    final response = await _apiService.delete<Map<String, dynamic>>(
      ApiEndpoints.doctorProfilePicture,
    );

    if (response['success'] == true && response['data'] != null) {
      return DoctorProfileModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to delete profile picture');
  }
}
