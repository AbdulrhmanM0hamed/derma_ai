import 'package:derma_ai/core/error/api_error_type.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'base_error_widget.dart';

class ServerErrorWidget extends BaseErrorWidget {
  final ApiErrorType serverErrorType;
  final int? statusCode;
  final String? serverMessage; // رسالة الـ server المخصصة

  const ServerErrorWidget({
    super.key,
    required this.serverErrorType,
    this.statusCode,
    this.serverMessage,
    super.onRetry,
    VoidCallback? onContactSupport,
  }) : super(
          title: '',
          description: '',
          icon: Icons.error_outline,
          onSecondaryAction: onContactSupport,
          secondaryActionText: '',
          primaryColor: Colors.red,
        );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    String title;
    String description;
    IconData iconData = Icons.error_outline;
    
    switch (serverErrorType) {
      case ApiErrorType.internalServerError:
        title = l10n!.error_internal_server_error;
        description = l10n.error_internal_server_error_desc;
        iconData = Icons.dns;
        break;
      case ApiErrorType.badGateway:
        title = l10n!.error_bad_gateway;
        description = l10n.error_bad_gateway_desc;
        iconData = Icons.router;
        break;
      case ApiErrorType.serviceUnavailable:
        title = l10n!.error_service_unavailable;
        description = l10n.error_service_unavailable_desc;
        iconData = Icons.cloud_off;
        break;
      case ApiErrorType.gatewayTimeout:
        title = l10n!.error_gateway_timeout;
        description = l10n.error_gateway_timeout_desc;
        iconData = Icons.access_time;
        break;
      default:
        title = l10n!.error_server_error;
        description = l10n.error_server_error_desc;
        iconData = Icons.error_outline;
    }
    
    // استخدام رسالة الـ server إذا كانت متاحة، وإلا استخدم الوصف المترجم
    final finalDescription = serverMessage?.isNotEmpty == true ? serverMessage! : description;
    
    return BaseErrorWidget(
      title: statusCode != null ? '$title ($statusCode)' : title,
      description: finalDescription,
      icon: iconData,
      onRetry: onRetry,
      onSecondaryAction: onSecondaryAction,
      secondaryActionText: l10n.contact_support,
      primaryColor: Colors.red,
    );
  }

  @override
  String getRetryButtonText(BuildContext context) {
    return AppLocalizations.of(context)!.retry;
  }
}
