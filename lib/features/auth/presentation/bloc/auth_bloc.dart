import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/request_password_reset_otp_usecase.dart';
import '../../domain/usecases/verify_password_reset_otp_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final ResendOtpUsecase _resendOtpUsecase;
  final LogoutUsecase _logoutUsecase;
  final RequestPasswordResetOtpUsecase _requestPasswordResetOtpUsecase;
  final VerifyPasswordResetOtpUsecase _verifyPasswordResetOtpUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;

  AuthCubit({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required ResendOtpUsecase resendOtpUsecase,
    required LogoutUsecase logoutUsecase,
    required RequestPasswordResetOtpUsecase requestPasswordResetOtpUsecase,
    required VerifyPasswordResetOtpUsecase verifyPasswordResetOtpUsecase,
    required ResetPasswordUsecase resetPasswordUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        _verifyOtpUsecase = verifyOtpUsecase,
        _resendOtpUsecase = resendOtpUsecase,
        _logoutUsecase = logoutUsecase,
        _requestPasswordResetOtpUsecase = requestPasswordResetOtpUsecase,
        _verifyPasswordResetOtpUsecase = verifyPasswordResetOtpUsecase,
        _resetPasswordUsecase = resetPasswordUsecase,
        super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await _loginUsecase(LoginParams(
      email: email,
      password: password,
    ));

    result.fold(
      (failure) => emit(LoginFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (entity) => emit(LoginSuccess(entity)),
    );
  }

  Future<void> register({
    required String email,
    required String phone,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());

    final result = await _registerUsecase(RegisterParams(
      email: email,
      phone: phone,
      password: password,
      fullName: fullName,
    ));

    result.fold(
      (failure) => emit(RegisterFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (entity) => emit(RegisterSuccess(entity)),
    );
  }

  Future<void> verifyOtp({
    required int userId,
    required String otp,
    required String type,
  }) async {
    emit(AuthLoading());

    final result = await _verifyOtpUsecase(VerifyOtpParams(
      userId: userId,
      otp: otp,
      type: type,
    ));

    result.fold(
      (failure) => emit(VerifyOtpFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (entity) => emit(VerifyOtpSuccess(entity)),
    );
  }

  Future<void> resendOtp({
    required int userId,
    required String type,
  }) async {
    emit(AuthLoading());

    final result = await _resendOtpUsecase(ResendOtpParams(
      userId: userId,
      type: type,
    ));

    result.fold(
      (failure) => emit(ResendOtpFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (data) => emit(ResendOtpSuccess(
        messageEn: data['message_en'] ?? 'OTP sent successfully',
        messageAr: data['message_ar'] ?? 'تم إرسال الرمز بنجاح',
      )),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _logoutUsecase();
    result.fold(
      (failure) => emit(LogoutFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (_) => emit(LogoutSuccess(
        messageEn: 'Logged out successfully',
        messageAr: 'تم تسجيل الخروج بنجاح',
      )),
    );
  }

  Future<void> requestPasswordResetOtp({
    required String email,
    required String type,
  }) async {
    emit(AuthLoading());
    final result = await _requestPasswordResetOtpUsecase(RequestPasswordResetOtpParams(
      email: email,
      type: type,
    ));
    result.fold(
      (failure) => emit(RequestPasswordResetOtpFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (entity) => emit(RequestPasswordResetOtpSuccess(
        messageEn: entity.messageEn,
        messageAr: entity.messageAr,
      )),
    );
  }

  Future<void> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoading());
    final result = await _verifyPasswordResetOtpUsecase(VerifyPasswordResetOtpParams(
      email: email,
      otp: otp,
    ));
    result.fold(
      (failure) => emit(VerifyPasswordResetOtpFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (entity) => emit(VerifyPasswordResetOtpSuccess(
        messageEn: entity.messageEn,
        messageAr: entity.messageAr,
        resetToken: entity.resetToken ?? '',
      )),
    );
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    emit(AuthLoading());
    final result = await _resetPasswordUsecase(ResetPasswordParams(
      token: token,
      newPassword: newPassword,
    ));
    result.fold(
      (failure) => emit(ResetPasswordFailure(
        messageEn: failure.message,
        messageAr: failure.messageAr,
      )),
      (entity) => emit(ResetPasswordSuccess(
        messageEn: entity.messageEn,
        messageAr: entity.messageAr,
      )),
    );
  }
}
