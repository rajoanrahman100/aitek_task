import 'package:aitek_task/core/utils/logger.dart';
import 'package:dio/dio.dart';

/// Custom Exceptions for network and API responses.
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseData;

  NetworkException({required this.message, this.statusCode, this.responseData});

  @override
  String toString() => message;
}

class ConnectionException extends NetworkException {
  ConnectionException({
    super.message =
        'Connection timed out. Please check your internet connection.',
  });
}

class ServerResponseException extends NetworkException {
  ServerResponseException({
    required super.message,
    required super.statusCode,
    super.responseData,
  });
}

class NoInternetException extends NetworkException {
  NoInternetException({super.message = 'No internet connection detected.'});
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException({
    super.message = 'Unauthorized. Please check your credentials.',
    super.statusCode = 401,
    super.responseData,
  });
}

class UnknownNetworkException extends NetworkException {
  UnknownNetworkException({required super.message, super.responseData});
}

/// A wrapper around [Dio] that provides robust error handling, logging,
/// and dynamic base URL matching.
class DioClient {
  final Dio _dio;

  DioClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.sendTimeout = const Duration(seconds: 15);

    // Add custom logging interceptor
    _dio.interceptors.add(_LoggingInterceptor());
  }

  /// Helper to build the final URL, trimming the path and resolving custom baseUrl if provided.
  String _buildUrl(String path, String? baseUrl) {
    final cleanPath = path.trim();
    if (baseUrl == null) return cleanPath;
    if (baseUrl.trim().isEmpty) {
      throw UnknownNetworkException(message: 'Base URL is not configured.');
    }
    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return cleanPath;
    }
    final cleanBaseUrl = baseUrl.trim().endsWith('/')
        ? baseUrl.trim()
        : '${baseUrl.trim()}/';
    final cleanRelativePath = cleanPath.startsWith('/')
        ? cleanPath.substring(1)
        : cleanPath;
    return '$cleanBaseUrl$cleanRelativePath';
  }

  /// GET Request wrapper.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    String? baseUrl,
  }) async {
    try {
      final url = _buildUrl(path, baseUrl);
      final response = await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownNetworkException(message: e.toString());
    }
  }

  /// POST Request wrapper.
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    String? baseUrl,
  }) async {
    try {
      final url = _buildUrl(path, baseUrl);
      final response = await _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownNetworkException(message: e.toString());
    }
  }

  /// Maps [DioException] to standard custom exception classes.
  NetworkException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ConnectionException();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final statusMessage =
            e.response?.statusMessage ?? 'Bad response from server';
        final errorData = e.response?.data;

        if (statusCode == 401) {
          return UnauthorizedException(responseData: errorData);
        }

        String errorMsg = statusMessage;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMsg = errorData['message'].toString();
        } else if (errorData != null) {
          errorMsg = errorData.toString();
        }
        return ServerResponseException(
          message: errorMsg,
          statusCode: statusCode,
          responseData: errorData,
        );
      case DioExceptionType.cancel:
        return NetworkException(message: 'Request was cancelled.');
      case DioExceptionType.connectionError:
        return ConnectionException(
          message:
              'Failed to connect to the server. Please check your internet connection.',
        );
      default:
        return UnknownNetworkException(
          message: e.message ?? 'An unknown network error occurred.',
        );
    }
  }
}

/// Custom Interceptor for clean and pretty logging of requests and responses.
class _LoggingInterceptor extends Interceptor {
  _LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('--> ${options.method} ${options.uri}');
    if (options.headers.isNotEmpty) {
      logger.d('Headers: ${options.headers}');
    }
    if (options.queryParameters.isNotEmpty) {
      logger.d('QueryParameters: ${options.queryParameters}');
    }
    if (options.data != null) {
      logger.d('Request Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
      '<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    logger.d('Response Body: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      '<-- ERROR ${err.response?.statusCode ?? 'Unknown Status'} ${err.requestOptions.method} ${err.requestOptions.uri}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    if (err.response?.data != null) {
      logger.e('Error Response Body: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
