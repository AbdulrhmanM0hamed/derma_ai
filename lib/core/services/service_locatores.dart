import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
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

  // Bloc
  sl.registerFactory(() => AuthCubit(
        authRepository: sl(),
        tokenStorage: sl(),
      ));
}