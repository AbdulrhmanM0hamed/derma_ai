import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final ResendOtpUsecase _resendOtpUsecase;

  AuthCubit({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required ResendOtpUsecase resendOtpUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        _verifyOtpUsecase = verifyOtpUsecase,
        _resendOtpUsecase = resendOtpUsecase,
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
}
