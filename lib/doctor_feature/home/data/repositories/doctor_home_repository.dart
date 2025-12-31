import 'package:derma_ai/core/network/api_service.dart';
import 'package:derma_ai/core/utils/constant/api_endpoints.dart';
import '../models/home_doctor_model.dart';

abstract class DoctorHomeRepository {
  Future<HomeDoctorModel> getDoctorProfile();
}

class DoctorHomeRepositoryImpl implements DoctorHomeRepository {
  final ApiService _apiService;

  DoctorHomeRepositoryImpl(this._apiService);

  // Get Doctor Profile
  @override
  Future<HomeDoctorModel> getDoctorProfile() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.doctorProfile,
    );

    if (response['success'] == true && response['data'] != null) {
      return HomeDoctorModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to load doctor profile');
  }
}
