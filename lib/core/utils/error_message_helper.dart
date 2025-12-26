import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../error/api_exception.dart';

extension ApiExceptionExtension on ApiException {
  /// الحصول على الرسالة المترجمة بناءً على اللغة الحالية
  String getLocalizedMessage(BuildContext context) {
    // إذا كانت الرسالة من الـ server، استخدمها مباشرة
    if (!isTranslationKey) {
      final locale = Localizations.localeOf(context).languageCode;
      // استخدام الرسالة العربية إذا كانت اللغة عربية ومتوفرة
      if (locale == 'ar' && messageAr != null) {
        return messageAr!;
      }
      return message;
    }

    // إذا كانت مفتاح ترجمة، ترجمها
    final l10n = AppLocalizations.of(context)!;
    return _translateKey(l10n, message);
  }

  /// ترجمة مفتاح الخطأ إلى النص المناسب
  String _translateKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'error_no_internet_connection':
        return l10n.error_no_internet_connection;
      case 'error_connection_timeout':
        return l10n.error_connection_timeout;
      case 'error_receive_timeout':
        return l10n.error_receive_timeout;
      case 'error_send_timeout':
        return l10n.error_send_timeout;
      case 'error_server_error':
        return l10n.error_server_error;
      case 'error_internal_server_error':
        return l10n.error_internal_server_error;
      case 'error_bad_gateway':
        return l10n.error_bad_gateway;
      case 'error_service_unavailable':
        return l10n.error_service_unavailable;
      case 'error_gateway_timeout':
        return l10n.error_gateway_timeout;
      case 'error_bad_request':
        return l10n.error_bad_request;
      case 'error_unauthorized':
        return l10n.error_unauthorized;
      case 'error_forbidden':
        return l10n.error_forbidden;
      case 'error_not_found':
        return l10n.error_not_found;
      case 'error_method_not_allowed':
        return l10n.error_method_not_allowed;
      case 'error_not_acceptable':
        return l10n.error_not_acceptable;
      case 'error_request_timeout':
        return l10n.error_request_timeout;
      case 'error_conflict':
        return l10n.error_conflict;
      case 'error_gone':
        return l10n.error_gone;
      case 'error_length_required':
        return l10n.error_length_required;
      case 'error_precondition_failed':
        return l10n.error_precondition_failed;
      case 'error_payload_too_large':
        return l10n.error_payload_too_large;
      case 'error_uri_too_long':
        return l10n.error_uri_too_long;
      case 'error_unsupported_media_type':
        return l10n.error_unsupported_media_type;
      case 'error_range_not_satisfiable':
        return l10n.error_range_not_satisfiable;
      case 'error_expectation_failed':
        return l10n.error_expectation_failed;
      case 'error_too_many_requests':
        return l10n.error_too_many_requests;
      case 'error_unknown':
        return l10n.error_unknown;
      case 'error_cancelled':
        return l10n.error_cancelled;
      case 'error_other':
        return l10n.error_other;
      default:
        return key; // إرجاع المفتاح نفسه إذا لم يتم العثور على ترجمة
    }
  }
}
