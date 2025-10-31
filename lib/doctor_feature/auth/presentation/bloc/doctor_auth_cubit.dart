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
  })  : _authRepository = authRepository,
        _tokenStorage = tokenStorage,
        super(DoctorAuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await _authRepository.login(request);
      
      // Check if account is not verified FIRST (before checking success)
      if (response.accountNotVerified == true) {
        emit(DoctorAccountNotVerified(
          userId: response.userId ?? 0,
          messageEn: response.messageEn,
          messageAr: response.messageAr,
          requiresVerification: response.requiresVerification ?? {'email': true},
        ));
        return;
      }
      
      if (!response.success) {
        emit(DoctorLoginFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
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

      // If we reach here, login was successful
      emit(DoctorLoginSuccess(
        entity: response.user ?? UserModel(
          id: response.userId ?? 0,
          uuid: '',
          email: '',
          status: '',
        ),
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on DioException catch (_) {
      emit(DoctorLoginFailure(
        messageEn: 'Login failed',
        messageAr: 'فشل تسجيل الدخول',
      ));
    } on ApiException catch (e) {
      emit(DoctorLoginFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorLoginFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
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
      );

      final response = await _authRepository.register(request);
      
      if (!response.success) {
        emit(DoctorRegisterFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(DoctorRegisterSuccess(
        entity: response.user ?? UserModel(
          id: response.userId ?? 0,
          uuid: '',
          email: '',
          status: 'pending_verification',
        ),
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(DoctorRegisterFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorRegisterFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> logout() async {
    emit(DoctorAuthLoading());

    try {
      // إذا لم يكن هناك access token، نقوم بالـ logout محلياً فقط
      if (_tokenStorage.accessToken == null || _tokenStorage.accessToken!.isEmpty) {
        await _tokenStorage.clearTokens();
        emit(DoctorLogoutSuccess(
          messageEn: 'Logged out successfully',
          messageAr: 'تم تسجيل الخروج بنجاح',
        ));
        return;
      }
      
      // محاولة logout من السيرفر
      await _authRepository.logout();
      await _tokenStorage.clearTokens();
      
      emit(DoctorLogoutSuccess(
        messageEn: 'Logged out successfully',
        messageAr: 'تم تسجيل الخروج بنجاح',
      ));
    } on ApiException catch (e) {
      // حتى لو فشل الـ logout من السيرفر، نقوم بالـ logout محلياً
      await _tokenStorage.clearTokens();
      
      // إذا كان الخطأ 401 (Unauthorized)، نعتبره logout ناجح
      if (e.statusCode == 401) {
        emit(DoctorLogoutSuccess(
          messageEn: 'Logged out successfully',
          messageAr: 'تم تسجيل الخروج بنجاح',
        ));
      } else {
        emit(DoctorLogoutFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ));
      }
    } catch (e) {
      // حتى لو فشل الـ logout من السيرفر، نقوم بالـ logout محلياً
      await _tokenStorage.clearTokens();
      
      emit(DoctorLogoutFailure(
        messageEn: 'Logout completed locally due to connection error',
        messageAr: 'تم تسجيل الخروج محلياً بسبب خطأ في الاتصال',
      ));
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
        emit(DoctorVerifyOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(DoctorVerifyOtpSuccess(
        entity: UserModel(
          id: userId,
          uuid: '',
          email: '',
          status: 'verified',
          emailVerifiedAt: DateTime.now().toIso8601String(),
        ),
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(DoctorVerifyOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorVerifyOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> resendOtp({
    required int userId,
    required String type,
  }) async {
    emit(DoctorAuthLoading());

    try {
      final request = ResendOtpRequestModel(
        userId: userId,
        type: type,
      );

      final response = await _authRepository.resendOtp(request);
      
      if (!response.success) {
        emit(DoctorResendOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(DoctorResendOtpSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(DoctorResendOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorResendOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> requestPasswordResetOtp({
    required String email,
    required String type,
  }) async {
    emit(DoctorAuthLoading());
    
    try {
      final request = ForgetPasswordRequestModel(
        email: email,
        type: type,
      );

      final response = await _authRepository.forgetPassword(request);
      
      if (!response.success) {
        emit(DoctorRequestPasswordResetOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(DoctorRequestPasswordResetOtpSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(DoctorRequestPasswordResetOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorRequestPasswordResetOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
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
        emit(DoctorVerifyPasswordResetOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(DoctorVerifyPasswordResetOtpSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
        resetToken: otp,
      ));
    } on ApiException catch (e) {
      emit(DoctorVerifyPasswordResetOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorVerifyPasswordResetOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
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
        emit(DoctorResetPasswordFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(DoctorResetPasswordSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(DoctorResetPasswordFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(DoctorResetPasswordFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }
}
