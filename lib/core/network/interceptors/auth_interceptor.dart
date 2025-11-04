import 'package:dio/dio.dart';
import '../../services/token_storage_service.dart';
import '../../utils/constant/api_endpoints.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorageService _tokenStorage;
  final Dio _dio;

  AuthInterceptor(this._tokenStorage, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add access token to all requests except auth endpoints
    if (!_isAuthEndpoint(options.path)) {
      final accessToken = _tokenStorage.accessToken;
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized or 403 with jwt expired
    if (err.response?.statusCode == 401 ||
        (err.response?.statusCode == 403 &&
            _isTokenExpired(err.response?.data))) {
      // Don't retry if it's already a refresh token request
      if (_isRefreshTokenEndpoint(err.requestOptions.path)) {
        // Refresh token itself is expired, logout user
        await _tokenStorage.clearTokens();
        handler.next(err);
        return;
      }

      // Try to refresh the token
      try {
        final newAccessToken = await _refreshToken();
        if (newAccessToken != null) {
          // Retry the original request with new token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          final response = await _dio.fetch(options);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        // Refresh failed, clear tokens and pass error
        await _tokenStorage.clearTokens();
        handler.next(err);
        return;
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = _tokenStorage.refreshToken;
      if (refreshToken == null) {
        return null;
      }

      // Determine which refresh endpoint to use based on entity type
      final entityType = _tokenStorage.entityType;
      final refreshEndpoint = entityType == 'doctor'
          ? ApiEndpoints.refreshTokenDoctor
          : ApiEndpoints.refreshToken;

      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}$refreshEndpoint',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final newAccessToken = data['data']['accessToken'] as String?;
        final newRefreshToken = data['data']['refreshToken'] as String?;

        if (newAccessToken != null) {
          await _tokenStorage.saveAccessToken(newAccessToken);
          if (newRefreshToken != null) {
            await _tokenStorage.saveRefreshToken(newRefreshToken);
          }
          return newAccessToken;
        }
      }

      return null;
    } catch (e) {
      print('[AuthInterceptor] Refresh token failed: $e');
      return null;
    }
  }

  bool _isAuthEndpoint(String path) {
    final authEndpoints = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.verifyOtp,
      ApiEndpoints.loginDoctor,
      ApiEndpoints.registerDoctor,
      ApiEndpoints.verifyOtpDoctor,
      ApiEndpoints.refreshToken,
      ApiEndpoints.refreshTokenDoctor,
    ];

    return authEndpoints.any((endpoint) => path.contains(endpoint));
  }

  bool _isRefreshTokenEndpoint(String path) {
    return path.contains(ApiEndpoints.refreshToken) ||
        path.contains(ApiEndpoints.refreshTokenDoctor);
  }

  bool _isTokenExpired(dynamic responseData) {
    if (responseData is Map) {
      final error = responseData['error']?.toString().toLowerCase() ?? '';
      final details = responseData['details']?.toString().toLowerCase() ?? '';
      return error.contains('token') ||
          details.contains('jwt expired') ||
          details.contains('token expired');
    }
    return false;
  }
}
