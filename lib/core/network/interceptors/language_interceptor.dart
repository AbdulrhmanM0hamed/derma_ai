import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../services/token_storage_service.dart';
import '../../services/service_locatores.dart';

class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // الحصول على اللغة الحالية من النظام
    final currentLocale = _getCurrentLocale();
    
    // إضافة header اللغة حسب لغة التطبيق
    options.headers['lang'] = currentLocale.languageCode;
    
    // يمكن أيضاً إضافة Accept-Language header
    options.headers['Accept-Language'] = currentLocale.languageCode;
    
    // إضافة Authorization header إذا كان متاحاً
    try {
      final tokenStorage = sl<TokenStorageService>();
      final accessToken = tokenStorage.accessToken;
      
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {
      // في حالة عدم توفر TokenStorageService أو خطأ في الحصول على التوكن
      print('Error getting access token: $e');
    }
    
    super.onRequest(options, handler);
  }
  
  Locale _getCurrentLocale() {
    // محاولة الحصول على اللغة من BuildContext إذا كان متاحاً
    try {
      final context = _getContext();
      if (context != null) {
        final locale = Localizations.localeOf(context);
        // التأكد من أن اللغة مدعومة
        if (locale.languageCode == 'ar' || locale.languageCode == 'en') {
          return locale;
        }
      }
    } catch (e) {
      // في حالة عدم توفر context
      print('Error getting locale from context: $e');
    }
    
    // الرجوع إلى اللغة الافتراضية من النظام
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    
    // التأكد من أن اللغة مدعومة (عربي أو إنجليزي)
    if (systemLocale.languageCode == 'ar') {
      return const Locale('ar');
    } else {
      return const Locale('en'); // افتراضي إنجليزي
    }
  }
  
  BuildContext? _getContext() {
    // محاولة الحصول على context من NavigatorKey إذا كان متاحاً
    try {
      return NavigatorKey.currentContext;
    } catch (e) {
      return null;
    }
  }
}

// Global NavigatorKey للوصول إلى context
class NavigatorKey {
  static final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  
  static GlobalKey<NavigatorState> get key => _key;
  
  static BuildContext? get currentContext => _key.currentContext;
}
