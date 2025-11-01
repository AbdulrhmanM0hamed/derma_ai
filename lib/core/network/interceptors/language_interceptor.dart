import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../services/token_storage_service.dart';
import '../../services/service_locatores.dart';

class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // إضافة header اللغة العربية (ثابت للتطبيق العربي)
    options.headers['lang'] = 'ar';
    
    // يمكن أيضاً إضافة Accept-Language header
    options.headers['Accept-Language'] = 'ar';
    
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
        return Localizations.localeOf(context);
      }
    } catch (e) {
      // في حالة عدم توفر context
    }
    
    // الرجوع إلى اللغة الافتراضية من النظام
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    
    // التأكد من أن اللغة مدعومة (عربي أو إنجليزي)
    if (systemLocale.languageCode == 'ar') {
      return const Locale('ar');
    } else {
      return const Locale('en');
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
