import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user_features/auth/data/repositories/auth_user_repository.dart';
import '../../../user_features/auth/presentation/bloc/auth_cubit.dart';
import '../../../doctor_feature/auth/data/repositories/doctor_auth_repository.dart';
import '../../../doctor_feature/auth/presentation/bloc/doctor_auth_cubit.dart';
import '../../user_features/health_tips/data/repositories/health_tips_repository_new.dart';
import '../../user_features/health_tips/presentation/bloc/health_tips_cubit.dart';
import '../network/api_service.dart';
import '../services/token_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! Core Services
  sl.registerLazySingleton(() => TokenStorageService(sl()));
  sl.registerLazySingleton(() => ApiService());

  //! Features - Auth
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Doctor Repository
  sl.registerLazySingleton<DoctorAuthRepository>(
    () => DoctorAuthRepositoryImpl(sl()),
  );

  // Bloc
  sl.registerFactory(() => AuthCubit(
        authRepository: sl(),
        tokenStorage: sl(),
      ));

  // Doctor Bloc
  sl.registerFactory(() => DoctorAuthCubit(
        authRepository: sl<DoctorAuthRepository>(),
        tokenStorage: sl(),
      ));

  //! Features - Health Tips
  // Repository
  sl.registerLazySingleton<HealthTipsRepository>(
    () => HealthTipsRepositoryImpl(sl()),
  );

  // Cubit
  sl.registerFactory(() => HealthTipsCubit(sl()));
}