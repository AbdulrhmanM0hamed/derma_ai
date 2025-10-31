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
      
      emit(DoctorLoginSuccess(
        messageEn: 'Login successful',
        messageAr: 'تم تسجيل الدخول بنجاح',
      ));
    } on ApiException catch (e) {
      emit(DoctorLoginFailure(
        messageEn: e.message,
        messageAr: e.message,
      ));
    } catch (e) {
      emit(DoctorLoginFailure(
        messageEn: 'Login failed',
        messageAr: 'فشل تسجيل الدخول',
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
      
      emit(DoctorRegisterSuccess(
        messageEn: 'Registration successful',
        messageAr: 'تم التسجيل بنجاح',
      ));
    } on ApiException catch (e) {
      emit(DoctorRegisterFailure(
        messageEn: e.message,
        messageAr: e.message,
      ));
    } catch (e) {
      emit(DoctorRegisterFailure(
        messageEn: 'Registration failed',
        messageAr: 'فشل التسجيل',
      ));
    }
  }

  Future<void> logout() async {
    emit(DoctorAuthLoading());

    try {
      final response = await _authRepository.logout();
      
      // Clear stored tokens
      await _tokenStorage.clearTokens();
      
      emit(DoctorLogoutSuccess(
        messageEn: 'Logout successful',
        messageAr: 'تم تسجيل الخروج بنجاح',
      ));
    } on ApiException catch (e) {
      emit(DoctorLogoutFailure(
        messageEn: e.message,
        messageAr: e.message,
      ));
    } catch (e) {
      emit(DoctorLogoutFailure(
        messageEn: 'Logout failed',
        messageAr: 'فشل تسجيل الخروج',
      ));
    }
  }
}
