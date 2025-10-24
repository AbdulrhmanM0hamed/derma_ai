import 'package:derma_ai/core/error/dio_exception_handler.dart';
import 'package:dio/dio.dart';
import '../utils/constant/api_endpoints.dart';
import 'interceptors/language_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;
  
  // Base URL - يمكن تغييرها حسب البيئة
  static String get _baseUrl => ApiEndpoints.baseUrl;
  
  DioClient._internal() {
    _dio = Dio();
    _setupDio();
  }
  
  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
  }
  
  Dio get dio => _dio;
  
  void _setupDio() {
    // Base options
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    // Add interceptors
    _dio.interceptors.clear();
    _dio.interceptors.add(LanguageInterceptor());
    _dio.interceptors.add(RetryInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
  }
  
  // GET Request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }
  
  // POST Request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }
  
  // PUT Request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }
  
  // DELETE Request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }
  
  // PATCH Request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }
  
  // Update base URL
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }
  
  // Add authorization token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  // Remove authorization token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
  
  // Update language
  void updateLanguage(String languageCode) {
    _dio.options.headers['lang'] = languageCode;
  }
}
