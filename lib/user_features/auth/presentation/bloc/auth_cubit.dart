import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_user_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final TokenStorageService _tokenStorage;

  AuthCubit({
    required AuthRepository authRepository,
    required TokenStorageService tokenStorage,
  })  : _authRepository = authRepository,
        _tokenStorage = tokenStorage,
        super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await _authRepository.login(request);
      
      // Check if account is not verified FIRST (before checking success)
      if (response.accountNotVerified == true) {
        emit(AccountNotVerified(
          userId: response.userId ?? 0,
          messageEn: response.messageEn,
          messageAr: response.messageAr,
          requiresVerification: response.requiresVerification ?? {'email': true},
        ));
        return;
      }
      
      if (!response.success) {
        emit(LoginFailure(
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

      // Save entity type for refresh token mechanism
      await _tokenStorage.saveEntityType('user');

      // If we reach here, login was successful
      emit(LoginSuccess(
        entity: response.user ?? UserModel(
          id: response.userId ?? 0,
          uuid: '',
          email: '',
          status: '',
        ),
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on DioException {
      emit(LoginFailure(
        messageEn: 'Login failed',
        messageAr: 'فشل تسجيل الدخول',
      ));
    } on ApiException catch (e) {
      emit(LoginFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(LoginFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> register({
    required String email,
    required String phone,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());

    try {
      final request = SignupRequestModel(
        email: email,
        phone: phone,
        password: password,
        fullName: fullName,
      );

      final response = await _authRepository.register(request);
      
      if (!response.success) {
        emit(RegisterFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(RegisterSuccess(
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
      emit(RegisterFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(RegisterFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> verifyOtp({
    required int userId,
    required String otp,
    required String type,
  }) async {
    emit(AuthLoading());

    try {
      final request = CheckOtpRequestModel(
        userId: userId,
        otp: otp,
        type: type,
      );

      final response = await _authRepository.checkOtp(request);
      
      if (!response.success) {
        emit(VerifyOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(VerifyOtpSuccess(
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
      emit(VerifyOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(VerifyOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> resendOtp({
    required int userId,
    required String type,
  }) async {
    emit(AuthLoading());

    try {
      final request = ResendOtpRequestModel(
        userId: userId,
        type: type,
      );

      final response = await _authRepository.resendOtp(request);
      
      if (!response.success) {
        emit(ResendOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(ResendOtpSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(ResendOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(ResendOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    
    try {
      // إذا لم يكن هناك access token، نقوم بالـ logout محلياً فقط
      if (_tokenStorage.accessToken == null || _tokenStorage.accessToken!.isEmpty) {
        await _tokenStorage.clearTokens();
        emit(LogoutSuccess(
          messageEn: 'Logged out successfully',
          messageAr: 'تم تسجيل الخروج بنجاح',
        ));
        return;
      }
      
      // محاولة logout من السيرفر
      await _authRepository.logout();
      await _tokenStorage.clearTokens();
      
      emit(LogoutSuccess(
        messageEn: 'Logged out successfully',
        messageAr: 'تم تسجيل الخروج بنجاح',
      ));
    } on ApiException catch (e) {
      // حتى لو فشل الـ logout من السيرفر، نقوم بالـ logout محلياً
      await _tokenStorage.clearTokens();
      
      // إذا كان الخطأ 401 (Unauthorized)، نعتبره logout ناجح
      if (e.statusCode == 401) {
        emit(LogoutSuccess(
          messageEn: 'Logged out successfully',
          messageAr: 'تم تسجيل الخروج بنجاح',
        ));
      } else {
        emit(LogoutFailure(
          messageEn: e.message,
          messageAr: e.messageAr ?? e.message,
        ));
      }
    } catch (e) {
      // حتى لو فشل الـ logout من السيرفر، نقوم بالـ logout محلياً
      await _tokenStorage.clearTokens();
      
      emit(LogoutFailure(
        messageEn: 'Logout completed locally due to connection error',
        messageAr: 'تم تسجيل الخروج محلياً بسبب خطأ في الاتصال',
      ));
    }
  }

  Future<void> requestPasswordResetOtp({
    required String email,
    required String type,
  }) async {
    emit(AuthLoading());
    
    try {
      final request = ForgetPasswordRequestModel(
        email: email,
        type: type,
      );

      final response = await _authRepository.forgetPassword(request);
      
      if (!response.success) {
        emit(RequestPasswordResetOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(RequestPasswordResetOtpSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(RequestPasswordResetOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(RequestPasswordResetOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoading());
    
    try {
      final request = CheckOtpRequestModel(
        userId: 0,
        otp: otp,
        type: 'password_reset',
      );

      final response = await _authRepository.checkOtp(request);
      
      if (!response.success) {
        emit(VerifyPasswordResetOtpFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(VerifyPasswordResetOtpSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
        resetToken: otp,
      ));
    } on ApiException catch (e) {
      emit(VerifyPasswordResetOtpFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(VerifyPasswordResetOtpFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    emit(AuthLoading());
    
    try {
      final request = ChangePasswordRequestModel(
        token: token,
        newPassword: newPassword,
      );

      final response = await _authRepository.changePassword(request);
      
      if (!response.success) {
        emit(ResetPasswordFailure(
          messageEn: response.messageEn,
          messageAr: response.messageAr,
        ));
        return;
      }

      emit(ResetPasswordSuccess(
        messageEn: response.messageEn,
        messageAr: response.messageAr,
      ));
    } on ApiException catch (e) {
      emit(ResetPasswordFailure(
        messageEn: e.message,
        messageAr: e.messageAr ?? e.message,
      ));
    } catch (e) {
      emit(ResetPasswordFailure(
        messageEn: 'An unexpected error occurred',
        messageAr: 'حدث خطأ غير متوقع',
      ));
    }
  }
}
