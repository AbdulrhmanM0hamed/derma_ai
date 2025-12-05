import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  static const String _localeKey = 'app_locale';

  LocaleCubit() : super(LocaleState(const Locale('ar'))) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey) ?? 'ar';
      emit(LocaleState(Locale(localeCode)));
    } catch (e) {
      // Use default Arabic if loading fails
      emit(LocaleState(const Locale('ar')));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
      emit(LocaleState(locale));
    } catch (e) {
      // Keep current locale if save fails
    }
  }
}
