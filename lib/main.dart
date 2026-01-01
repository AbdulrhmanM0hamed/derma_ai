import 'package:derma_ai/doctor_feature/home/presentation/pages/doctor_home_page.dart';
import 'package:derma_ai/doctor_feature/navigation/presentation/pages/doctor_navigation_page.dart';
import 'package:derma_ai/doctor_feature/packages/presentation/pages/packages_page.dart';
import 'package:derma_ai/user_features/home/presentation/widgets/home_features_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'user_features/location/presentation/bloc/location_cubit.dart';
import 'user_features/profile/presentation/bloc/profile_cubit.dart';
import 'core/cubit/locale/locale_cubit.dart';
import 'core/cubit/theme/theme_cubit.dart';
import 'core/services/service_locatores.dart' as di;
import 'core/utils/helper/on_genrated_routes.dart';
import 'core/utils/theme/app_theme.dart';
import 'core/network/interceptors/language_interceptor.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Service Locator
  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => di.sl<LocationCubit>()),
        BlocProvider(create: (_) => di.sl<ProfileCubit>()..getUserProfile()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp(
                title: 'DermaAI',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                debugShowCheckedModeBanner: false,
                navigatorKey: NavigatorKey.key,
                // initialRoute: AppRoutes.splash,
                // onGenerateRoute: onGeneratedRoutes,
                home: DoctorNavigationPage(),
                locale: localeState.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
