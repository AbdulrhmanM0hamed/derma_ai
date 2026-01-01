import 'package:derma_ai/doctor_feature/home/data/repositories/doctor_home_repository.dart';
import 'package:derma_ai/doctor_feature/home/presentation/cubit/doctor_home_cubit.dart';
import 'package:derma_ai/doctor_feature/packages/data/repositories/packages_repository.dart';
import 'package:derma_ai/doctor_feature/packages/presentation/cubit/packages_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user_features/auth/data/repositories/auth_user_repository.dart';
import '../../../user_features/auth/presentation/bloc/auth_cubit.dart';
import '../../../doctor_feature/auth/data/repositories/doctor_auth_repository.dart';
import '../../../doctor_feature/auth/presentation/bloc/doctor_auth_cubit.dart';
import '../../user_features/health_tips/data/repositories/health_tips_repository_new.dart';
import '../../user_features/health_tips/presentation/bloc/health_tips_cubit.dart';
import '../../user_features/profile/data/repositories/profile_repository.dart';
import '../../user_features/profile/presentation/bloc/profile_cubit.dart';
import '../../user_features/location/data/repositories/location_repository.dart';
import '../../user_features/location/presentation/bloc/location_cubit.dart';
import '../../doctor_feature/profile/data/repositories/doctor_profile_repository.dart';
import '../../doctor_feature/profile/presentation/bloc/doctor_profile_cubit.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';
import '../services/token_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! Core Services
  sl.registerLazySingleton(() => TokenStorageService(sl()));
  sl.registerLazySingleton(() => ApiService());

  // Initialize DioClient with Auth Interceptor
  DioClient.instance.initializeAuth(sl<TokenStorageService>());

  //! Features - Auth
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Doctor Repository
  sl.registerLazySingleton<DoctorAuthRepository>(
    () => DoctorAuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<DoctorHomeRepository>(
    () => DoctorHomeRepositoryImpl(sl()),
  );

  // Bloc
  sl.registerFactory(() => AuthCubit(authRepository: sl(), tokenStorage: sl()));

  // Doctor Bloc
  sl.registerFactory(
    () => DoctorAuthCubit(
      authRepository: sl<DoctorAuthRepository>(),
      tokenStorage: sl(),
    ),
  );
  sl.registerFactory(() => DoctorHomeCubit(sl()));

  //! Features - Health Tips
  // Repository
  sl.registerLazySingleton<HealthTipsRepository>(
    () => HealthTipsRepositoryImpl(sl()),
  );

  // Cubit
  sl.registerFactory(() => HealthTipsCubit(sl()));

  //! Features - Profile
  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // Cubit - Changed to singleton to maintain state across navigation
  sl.registerLazySingleton(() => ProfileCubit(sl()));

  //! Features - Location
  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );

  // Cubit
  sl.registerFactory(() => LocationCubit(sl(), sl()));

  //! Features - Doctor Profile
  // Repository
  sl.registerLazySingleton<DoctorProfileRepository>(
    () => DoctorProfileRepositoryImpl(sl()),
  );

  // Cubit
  sl.registerLazySingleton(() => DoctorProfileCubit(sl()));

  //! Features - Packages

  // cubit
  sl.registerLazySingleton(() => PackagesCubit(sl<PackagesRepositoryImpl>()));

  // Repository
  sl.registerLazySingleton(() => PackagesRepositoryImpl(sl()));
}
