import 'api_error_type.dart';

class ApiException implements Exception {
  final ApiErrorType errorType;
  final String message;
  final String? messageAr;
  final int? statusCode;
  final dynamic response;
  final bool isTranslationKey; // هل الرسالة مفتاح ترجمة أم نص مباشر

  const ApiException({
    required this.errorType,
    required this.message,
    this.messageAr,
    this.statusCode,
    this.response,
    this.isTranslationKey = false,
  });

  @override
  String toString() {
    // إرجاع الرسالة فقط بدون تفاصيل تقنية للمستخدم النهائي
    return message;
  }
}
