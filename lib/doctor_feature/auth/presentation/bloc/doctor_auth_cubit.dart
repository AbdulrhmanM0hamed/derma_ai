import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../../../user_features/auth/data/models/auth_models.dart';
import '../../data/repositories/doctor_auth_repository.dart';
import 'doctor_auth_state.dart';

class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  final DoctorAuthRepository _authRepository;
  final TokenStorageService _tokenStorage;

  DoctorAuthCubit({
    required DoctorAuthRepository authRepository,
    required TokenStorageService tokenStorage,
  }) : _authRepository = authRepository,
       _tokenStorage = tokenStorage,
       super(DoctorAuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(DoctorAuthLoading());
    //print('🟢 DoctorAuthCubit.login called with email: $email');

    try {
      final request = LoginRequestModel(email: email, password: password);

      final response = await _authRepository.login(request);
      //print('🟢 API Response received');
      //print('🟢 success: ${response.success}');
      //print('🟢 accountNotVerified: ${response.accountNotVerified}');
      //print('🟢 userId: ${response.userId}');
      //print('🟢 messageAr: ${response.messageAr}');
      //print('🟢 messageEn: ${response.messageEn}');

      // Check if account is not verified FIRST (before checking success)
      if (response.accountNotVerified == true) {
        //print('🟢 Emitting DoctorAccountNotVerified state...');
        emit(
          DoctorAccountNotVerified(
            userId: response.userId ?? 0,
            messageEn: response.messageEn,
            messageAr: response.messageAr,
            requiresVerification:
                response.requiresVerification ?? {'email': true},
          ),
        );
        //print('🟢 DoctorAccountNotVerified state emitted');
        return;
      }

      if (!response.success) {
        //print('🟢 Emitting DoctorLoginFailure (not successful)...');
        emit(
          DoctorLoginFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      // Save tokens if login successful
      if (response.tokens != null) {
        await _tokenStorage.saveTokens(
          accessToken: response.tokens!.accessToken,
          refreshToken: response.tokens!.refreshToken,
          sessionToken: response.tokens!.sessionToken,
        );
      }

      // Save user data if available
      if (response.user != null) {
        await _tokenStorage.saveUserData(
          userId: response.user!.id,
          userUuid: response.user!.uuid,
          userEmail: response.user!.email,
          userStatus: response.user!.status,
        );
      }

      // Save entity type for refresh token mechanism
      await _tokenStorage.saveEntityType('doctor');

      // If we reach here, login was successful
      //print('🟢 Emitting DoctorLoginSuccess...');
      emit(
        DoctorLoginSuccess(
          entity:
              response.user ??
              UserModel(
                id: response.userId ?? 0,
                uuid: '',
                email: '',
                status: '',
              ),
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ),
      );
    } on DioException catch (e) {
      //print('🟢 DioException caught: ${e.message}');
      //print('🟢 Response data: ${e.response?.data}');

      // Check if error response contains accountNotVerified
      if (e.response?.data != null && e.response?.data is Map) {
        final errorData = e.response!.data as Map<String, dynamic>;
        if (errorData['accountNotVerified'] == true) {
          //print('🟢 Account not verified detected in error response');
          emit(
            DoctorAccountNotVerified(
              userId: errorData['userId'] ?? 0,
              messageEn: errorData['message_en'] ?? 'Account not verified',
              messageAr: errorData['message_ar'] ?? 'الحساب غير مفعل',
              requiresVerification:
                  errorData['requiresVerification'] != null
                      ? Map<String, bool>.from(
                        errorData['requiresVerification'],
                      )
                      : {'email': true},
            ),
          );
          return;
        }
      }

      emit(
        DoctorLoginFailure(
          messageEn: 'Login failed',
          messageAr: 'فشل تسجيل الدخول',
        ),
      );
    } on ApiException catch (e) {
      //print('🟢 ApiException caught: ${e.message}');

      // Check if ApiException has response data with accountNotVerified
      // e.response is dynamic, but it holds the Dio Response object
      if (e.response != null && e.response is Response) {
        final response = e.response as Response;
        if (response.data != null && response.data is Map) {
          final errorData = response.data as Map<String, dynamic>;

          if (errorData['accountNotVerified'] == true) {
            //print(
            //   '🟢 Account not verified detected in ApiException response data',
            // );
            emit(
              DoctorAccountNotVerified(
                userId: errorData['userId'] ?? 0,
                messageEn: errorData['message_en'] ?? e.message,
                messageAr: errorData['message_ar'] ?? e.messageAr ?? e.message,
                requiresVerification:
                    errorData['requiresVerification'] != null
                        ? Map<String, bool>.from(
                          errorData['requiresVerification'],
                        )
                        : {'email': true},
              ),
            );
            return;
          }
        }
      }

      emit(
        DoctorLoginFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorLoginFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String licenseNumber,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = SignupRequestModel(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        licenseNumber: licenseNumber,
      );

      final response = await _authRepository.register(request);

      if (!response.success) {
        emit(
          DoctorRegisterFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      emit(
        DoctorRegisterSuccess(
          entity:
              response.user ??
              UserModel(
                id: response.userId ?? 0,
                uuid: '',
                email: '',
                status: 'pending_verification',
              ),
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ),
      );
    } on ApiException catch (e) {
      emit(
        DoctorRegisterFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorRegisterFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(DoctorAuthLoading());

    try {
      // إذا لم يكن هناك access token، نقوم بالـ logout محلياً فقط
      if (_tokenStorage.accessToken == null ||
          _tokenStorage.accessToken!.isEmpty) {
        await _tokenStorage.clearTokens();
        emit(
          DoctorLogoutSuccess(
            messageEn: 'Logged out successfully',
            messageAr: 'تم تسجيل الخروج بنجاح',
          ),
        );
        return;
      }

      // محاولة logout من السيرفر
      await _authRepository.logout();
      await _tokenStorage.clearTokens();

      emit(
        DoctorLogoutSuccess(
          messageEn: 'Logged out successfully',
          messageAr: 'تم تسجيل الخروج بنجاح',
        ),
      );
    } on ApiException catch (e) {
      // حتى لو فشل الـ logout من السيرفر، نقوم بالـ logout محلياً
      await _tokenStorage.clearTokens();

      // إذا كان الخطأ 401 (Unauthorized)، نعتبره logout ناجح
      if (e.statusCode == 401) {
        emit(
          DoctorLogoutSuccess(
            messageEn: 'Logged out successfully',
            messageAr: 'تم تسجيل الخروج بنجاح',
          ),
        );
      } else {
        emit(
          DoctorLogoutFailure(
            messageEn: e.message,
            messageAr: e.messageAr ?? e.message,
          ),
        );
      }
    } catch (e) {
      // حتى لو فشل الـ logout من السيرفر، نقوم بالـ logout محلياً
      await _tokenStorage.clearTokens();

      emit(
        DoctorLogoutFailure(
          messageEn: 'Logout completed locally due to connection error',
          messageAr: 'تم تسجيل الخروج محلياً بسبب خطأ في الاتصال',
        ),
      );
    }
  }

  Future<void> verifyOtp({
    required int userId,
    required String otp,
    required String type,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = CheckOtpRequestModel(
        userId: userId,
        otp: otp,
        type: type,
      );

      final response = await _authRepository.checkOtp(request);

      if (!response.success) {
        emit(
          DoctorVerifyOtpFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      emit(
        DoctorVerifyOtpSuccess(
          entity: UserModel(
            id: userId,
            uuid: '',
            email: '',
            status: 'verified',
            emailVerifiedAt: DateTime.now().toIso8601String(),
          ),
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ),
      );
    } on ApiException catch (e) {
      emit(
        DoctorVerifyOtpFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorVerifyOtpFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }

  Future<void> resendOtp({required int userId, required String type}) async {
    emit(DoctorAuthLoading());

    try {
      final request = ResendOtpRequestModel(userId: userId, type: type);

      final response = await _authRepository.resendOtp(request);

      if (!response.success) {
        emit(
          DoctorResendOtpFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      emit(
        DoctorResendOtpSuccess(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ),
      );
    } on ApiException catch (e) {
      emit(
        DoctorResendOtpFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorResendOtpFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }

  Future<void> requestPasswordResetOtp({
    required String email,
    required String type,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = ForgetPasswordRequestModel(email: email, type: type);

      final response = await _authRepository.forgetPassword(request);

      if (!response.success) {
        emit(
          DoctorRequestPasswordResetOtpFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      emit(
        DoctorRequestPasswordResetOtpSuccess(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ),
      );
    } on ApiException catch (e) {
      emit(
        DoctorRequestPasswordResetOtpFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorRequestPasswordResetOtpFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }

  Future<void> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = CheckOtpRequestModel(
        userId: 0,
        otp: otp,
        type: 'password_reset',
      );

      final response = await _authRepository.checkOtp(request);

      if (!response.success) {
        emit(
          DoctorVerifyPasswordResetOtpFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      emit(
        DoctorVerifyPasswordResetOtpSuccess(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
          resetToken: otp,
        ),
      );
    } on ApiException catch (e) {
      emit(
        DoctorVerifyPasswordResetOtpFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorVerifyPasswordResetOtpFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = ChangePasswordRequestModel(
        token: token,
        newPassword: newPassword,
      );

      final response = await _authRepository.changePassword(request);

      if (!response.success) {
        emit(
          DoctorResetPasswordFailure(
            messageEn: response.messageEn,
            messageAr: response.messageAr,
          ),
        );
        return;
      }

      emit(
        DoctorResetPasswordSuccess(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ),
      );
    } on ApiException catch (e) {
      emit(
        DoctorResetPasswordFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ),
      );
    } catch (e) {
      emit(
        DoctorResetPasswordFailure(
          messageEn: 'An unexpected error occurred',
          messageAr: 'حدث خطأ غير متوقع',
        ),
      );
    }
  }
}
