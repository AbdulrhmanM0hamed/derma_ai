import 'dart:io';
import 'package:dio/dio.dart';
import 'api_exception.dart';
import 'api_error_type.dart';

class DioExceptionHandler {
  static ApiException handleDioException(DioException dioException) {
    ApiErrorType errorType;
    int? statusCode;

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        errorType = ApiErrorType.connectionTimeout;
        break;

      case DioExceptionType.sendTimeout:
        errorType = ApiErrorType.sendTimeout;
        break;

      case DioExceptionType.receiveTimeout:
        errorType = ApiErrorType.receiveTimeout;
        break;

      case DioExceptionType.badResponse:
        statusCode = dioException.response?.statusCode;
        errorType = _getErrorTypeFromStatusCode(statusCode);
        break;

      case DioExceptionType.cancel:
        errorType = ApiErrorType.cancelled;
        break;

      case DioExceptionType.connectionError:
        if (dioException.error is SocketException) {
          errorType = ApiErrorType.noInternetConnection;
        } else {
          errorType = ApiErrorType.unknown;
        }
        break;

      case DioExceptionType.badCertificate:
        errorType = ApiErrorType.other;
        break;

      case DioExceptionType.unknown:
        errorType = ApiErrorType.unknown;
        break;
    }

    // استخراج رسالة الخطأ من الـ server response
    final errorMessages = _extractErrorMessages(dioException, errorType);
    String errorMessage = errorMessages['messageEn'] ?? _getDefaultErrorMessage(errorType);
    String? errorMessageAr = errorMessages['messageAr'];

    // تحديد ما إذا كانت الرسالة من الـ server أم مفتاح ترجمة
    final isServerMessage = _isServerMessage(dioException, errorMessage);
    
    return ApiException(
      errorType: errorType,
      message: errorMessage,
      messageAr: errorMessageAr,
      statusCode: statusCode,
      response: dioException.response,
      isTranslationKey: !isServerMessage, // إذا لم تكن من الـ server، فهي مفتاح ترجمة
    );
  }

  static ApiErrorType _getErrorTypeFromStatusCode(int? statusCode) {
    if (statusCode == null) return ApiErrorType.unknown;

    switch (statusCode) {
      case 400:
        return ApiErrorType.badRequest;
      case 401:
        return ApiErrorType.unauthorized;
      case 403:
        return ApiErrorType.forbidden;
      case 404:
        return ApiErrorType.notFound;
      case 405:
        return ApiErrorType.methodNotAllowed;
      case 406:
        return ApiErrorType.notAcceptable;
      case 408:
        return ApiErrorType.requestTimeout;
      case 409:
        return ApiErrorType.conflict;
      case 410:
        return ApiErrorType.gone;
      case 411:
        return ApiErrorType.lengthRequired;
      case 412:
        return ApiErrorType.preconditionFailed;
      case 413:
        return ApiErrorType.payloadTooLarge;
      case 414:
        return ApiErrorType.uriTooLong;
      case 415:
        return ApiErrorType.unsupportedMediaType;
      case 416:
        return ApiErrorType.rangeNotSatisfiable;
      case 417:
        return ApiErrorType.expectationFailed;
      case 422:
        return ApiErrorType.badRequest; // Unprocessable Entity - validation errors
      case 429:
        return ApiErrorType.tooManyRequests;
      case 500:
        return ApiErrorType.internalServerError;
      case 502:
        return ApiErrorType.badGateway;
      case 503:
        return ApiErrorType.serviceUnavailable;
      case 504:
        return ApiErrorType.gatewayTimeout;
      default:
        if (statusCode >= 500) {
          return ApiErrorType.serverError;
        } else {
          return ApiErrorType.unknown;
        }
    }
  }

  /// استخراج رسائل الخطأ من الـ server response (عربي وإنجليزي)
  static Map<String, String?> _extractErrorMessages(DioException dioException, ApiErrorType errorType) {
    Map<String, String?> messages = {'messageEn': null, 'messageAr': null};
    
    try {
      final response = dioException.response;
      if (response?.data != null && response!.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        
        // استخراج الرسائل من الـ API الجديد
        if (data.containsKey('message_en') && data['message_en'] != null) {
          messages['messageEn'] = data['message_en'].toString();
        }
        
        if (data.containsKey('message_ar') && data['message_ar'] != null) {
          messages['messageAr'] = data['message_ar'].toString();
        }
        
        // إذا لم نجد الرسائل الجديدة، نحاول الـ API القديم
        if (messages['messageEn'] == null && data.containsKey('message') && data['message'] != null) {
          String message = data['message'].toString();
          
          // تنظيف الرسالة من النص الإضافي
          if (message.contains('(and ') && message.contains(' more errors)')) {
            if (data.containsKey('errors') && data['errors'] is Map<String, dynamic>) {
              final errors = data['errors'] as Map<String, dynamic>;
              List<String> errorMessages = [];
              
              errors.forEach((field, fieldErrors) {
                if (fieldErrors is List) {
                  for (var error in fieldErrors) {
                    errorMessages.add(error.toString());
                  }
                }
              });
              
              if (errorMessages.isNotEmpty) {
                messages['messageEn'] = errorMessages.join('\n');
                return messages;
              }
            }
            
            final cleanMessage = message.split('(and ')[0].trim();
            if (cleanMessage.isNotEmpty) {
              messages['messageEn'] = cleanMessage;
              return messages;
            }
          }
          
          messages['messageEn'] = message;
        }
        
        // محاولة استخراج من حقل error
        if (messages['messageEn'] == null && data.containsKey('error') && data['error'] != null) {
          messages['messageEn'] = data['error'].toString();
        }
      }
    } catch (e) {
      // في حالة الخطأ، نترك الرسائل null
    }
    
    return messages;
  }


  /// الحصول على رسالة الخطأ المترجمة حسب نوع الخطأ
  static String _getDefaultErrorMessage(ApiErrorType errorType) {
    switch (errorType) {
      case ApiErrorType.noInternetConnection:
        return 'No internet connection available';
      case ApiErrorType.connectionTimeout:
        return 'Connection timeout occurred';
      case ApiErrorType.receiveTimeout:
        return 'Response timeout occurred';
      case ApiErrorType.sendTimeout:
        return 'Request timeout occurred';
      case ApiErrorType.serverError:
        return 'Server error occurred';
      case ApiErrorType.internalServerError:
        return 'Internal server error';
      case ApiErrorType.badGateway:
        return 'Bad gateway error';
      case ApiErrorType.serviceUnavailable:
        return 'Service temporarily unavailable';
      case ApiErrorType.gatewayTimeout:
        return 'Gateway timeout error';
      case ApiErrorType.badRequest:
        return 'Invalid request data';
      case ApiErrorType.unauthorized:
        return 'Authentication required';
      case ApiErrorType.forbidden:
        return 'Access denied';
      case ApiErrorType.notFound:
        return 'Resource not found';
      case ApiErrorType.methodNotAllowed:
        return 'Method not allowed';
      case ApiErrorType.notAcceptable:
        return 'Request not acceptable';
      case ApiErrorType.requestTimeout:
        return 'Request timeout';
      case ApiErrorType.conflict:
        return 'Request conflict';
      case ApiErrorType.gone:
        return 'Resource no longer available';
      case ApiErrorType.lengthRequired:
        return 'Content length required';
      case ApiErrorType.preconditionFailed:
        return 'Precondition failed';
      case ApiErrorType.payloadTooLarge:
        return 'Request payload too large';
      case ApiErrorType.uriTooLong:
        return 'Request URI too long';
      case ApiErrorType.unsupportedMediaType:
        return 'Unsupported media type';
      case ApiErrorType.rangeNotSatisfiable:
        return 'Range not satisfiable';
      case ApiErrorType.expectationFailed:
        return 'Expectation failed';
      case ApiErrorType.tooManyRequests:
        return 'Too many requests';
      case ApiErrorType.unknown:
        return 'An unexpected error occurred';
      case ApiErrorType.cancelled:
        return 'Request was cancelled';
      case ApiErrorType.other:
        return 'An error occurred';
    }
  }

  /// تحديد ما إذا كانت الرسالة من الـ server أم مفتاح ترجمة
  static bool _isServerMessage(DioException dioException, String message) {
    try {
      final response = dioException.response;
      if (response?.data != null && response!.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        
        // التحقق من الـ API الجديد أولاً
        if (data.containsKey('message_en') && data['message_en'] != null) {
          if (message == data['message_en'].toString()) {
            return true;
          }
        }
        
        if (data.containsKey('message_ar') && data['message_ar'] != null) {
          if (message == data['message_ar'].toString()) {
            return true;
          }
        }
        
        // التحقق من الـ API القديم
        if (data.containsKey('message') && data['message'] != null) {
          final serverMessage = data['message'].toString();
          // التحقق من أن الرسالة تطابق رسالة الـ server (مع تنظيف النص الإضافي)
          if (message == serverMessage || message == serverMessage.split('(and ')[0].trim()) {
            return true;
          }
        }
        
        // التحقق من حقل error أيضاً
        if (data.containsKey('error') && data['error'] != null) {
          if (message == data['error'].toString()) {
            return true;
          }
        }
      }
    } catch (e) {
      // في حالة الخطأ، نفترض أنها ليست من الـ server
    }
    
    return false; // الرسالة مفتاح ترجمة
  }

}
