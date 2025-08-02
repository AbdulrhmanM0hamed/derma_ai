// import 'package:dio/dio.dart';

// import '../../../../core/services/dio_service.dart';
// import '../../../../core/utils/constant/api_endpoints.dart';
// import '../models/register_request_model.dart';
// import '../models/register_response_model.dart';
// import '../models/verify_otp_model.dart';

// class AuthRepository {
//   final DioService _dioService = DioService.instance;

//   // Register user
//   Future<RegisterResponseModel> register(RegisterRequestModel request) async {
//     try {
//       final response = await _dioService.post(
//         ApiEndpoints.register,
//         data: request.toJson(),
//       );

//       return RegisterResponseModel.fromJson(response.data);
//     } on DioException catch (e) {
//       final errorData = DioService.handleError(e);
//       return RegisterResponseModel.fromJson(errorData);
//     } catch (e) {
//       return RegisterResponseModel(
//         success: false,
//         messageEn: 'An unexpected error occurred',
//         messageAr: 'حدث خطأ غير متوقع',
//       );
//     }
//   }

//   // Verify OTP
//   Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
//     try {
//       final response = await _dioService.post(
//         ApiEndpoints.verifyOtp,
//         data: request.toJson(),
//       );

//       return VerifyOtpResponseModel.fromJson(response.data);
//     } on DioException catch (e) {
//       final errorData = DioService.handleError(e);
//       return VerifyOtpResponseModel.fromJson(errorData);
//     } catch (e) {
//       return VerifyOtpResponseModel(
//         success: false,
//         messageEn: 'An unexpected error occurred',
//         messageAr: 'حدث خطأ غير متوقع',
//       );
//     }
//   }

//   // Resend OTP
//   Future<Map<String, dynamic>> resendOtp({
//     required int userId,
//     required String type,
//   }) async {
//     try {
//       final response = await _dioService.post(
//         ApiEndpoints.resendOtp,
//         data: {
//           'userId': userId,
//           'type': type,
//         },
//       );

//       return response.data;
//     } on DioException catch (e) {
//       return DioService.handleError(e);
//     } catch (e) {
//       return {
//         'success': false,
//         'message_en': 'An unexpected error occurred',
//         'message_ar': 'حدث خطأ غير متوقع',
//       };
//     }
//   }
// }
