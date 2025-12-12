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

    // تحديد ما إذا كانت الرسالة من الـ server
    final hasServerMessage =
        errorMessages['messageEn'] != null ||
        errorMessages['messageAr'] != null;

    // استخدام رسالة الـ server إذا كانت موجودة، وإلا استخدم مفتاح الترجمة
    String errorMessage =
        hasServerMessage
            ? (errorMessages['messageEn'] ?? _getDefaultErrorMessage(errorType))
            : _getDefaultErrorMessage(errorType);
    String? errorMessageAr = errorMessages['messageAr'];

    return ApiException(
      errorType: errorType,
      message: errorMessage,
      messageAr: errorMessageAr,
      statusCode: statusCode,
      response: dioException.response,
      isTranslationKey:
          !hasServerMessage, // إذا لم تكن من الـ server، فهي مفتاح ترجمة
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
        return ApiErrorType
            .badRequest; // Unprocessable Entity - validation errors
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
  static Map<String, String?> _extractErrorMessages(
    DioException dioException,
    ApiErrorType errorType,
  ) {
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
        if (messages['messageEn'] == null &&
            data.containsKey('message') &&
            data['message'] != null) {
          String message = data['message'].toString();

          // تنظيف الرسالة من النص الإضافي
          if (message.contains('(and ') && message.contains(' more errors)')) {
            if (data.containsKey('errors') &&
                data['errors'] is Map<String, dynamic>) {
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
        if (messages['messageEn'] == null &&
            data.containsKey('error') &&
            data['error'] != null) {
          messages['messageEn'] = data['error'].toString();
        }
      }
    } catch (e) {
      // في حالة الخطأ، نترك الرسائل null
    }

    return messages;
  }

  /// الحصول على مفتاح الترجمة حسب نوع الخطأ
  static String _getDefaultErrorMessage(ApiErrorType errorType) {
    switch (errorType) {
      case ApiErrorType.noInternetConnection:
        return 'error_no_internet_connection';
      case ApiErrorType.connectionTimeout:
        return 'error_connection_timeout';
      case ApiErrorType.receiveTimeout:
        return 'error_receive_timeout';
      case ApiErrorType.sendTimeout:
        return 'error_send_timeout';
      case ApiErrorType.serverError:
        return 'error_server_error';
      case ApiErrorType.internalServerError:
        return 'error_internal_server_error';
      case ApiErrorType.badGateway:
        return 'error_bad_gateway';
      case ApiErrorType.serviceUnavailable:
        return 'error_service_unavailable';
      case ApiErrorType.gatewayTimeout:
        return 'error_gateway_timeout';
      case ApiErrorType.badRequest:
        return 'error_bad_request';
      case ApiErrorType.unauthorized:
        return 'error_unauthorized';
      case ApiErrorType.forbidden:
        return 'error_forbidden';
      case ApiErrorType.notFound:
        return 'error_not_found';
      case ApiErrorType.methodNotAllowed:
        return 'error_method_not_allowed';
      case ApiErrorType.notAcceptable:
        return 'error_not_acceptable';
      case ApiErrorType.requestTimeout:
        return 'error_request_timeout';
      case ApiErrorType.conflict:
        return 'error_conflict';
      case ApiErrorType.gone:
        return 'error_gone';
      case ApiErrorType.lengthRequired:
        return 'error_length_required';
      case ApiErrorType.preconditionFailed:
        return 'error_precondition_failed';
      case ApiErrorType.payloadTooLarge:
        return 'error_payload_too_large';
      case ApiErrorType.uriTooLong:
        return 'error_uri_too_long';
      case ApiErrorType.unsupportedMediaType:
        return 'error_unsupported_media_type';
      case ApiErrorType.rangeNotSatisfiable:
        return 'error_range_not_satisfiable';
      case ApiErrorType.expectationFailed:
        return 'error_expectation_failed';
      case ApiErrorType.tooManyRequests:
        return 'error_too_many_requests';
      case ApiErrorType.unknown:
        return 'error_unknown';
      case ApiErrorType.cancelled:
        return 'error_cancelled';
      case ApiErrorType.other:
        return 'error_other';
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
          if (message == serverMessage ||
              message == serverMessage.split('(and ')[0].trim()) {
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
