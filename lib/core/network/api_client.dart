import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' hide Environment;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../utils/exceptions.dart';
import '../../config/environment.dart';

@singleton
class ApiClient {
  late Dio _dio;
  final SharedPreferences _prefs;

  ApiClient(this._prefs) {
    _dio = Dio(BaseOptions(
      baseUrl: Environment.baseUrl,
      connectTimeout: const Duration(seconds: AppConstants.apiTimeoutSeconds),
      receiveTimeout: const Duration(seconds: AppConstants.apiTimeoutSeconds),
      sendTimeout: const Duration(seconds: AppConstants.apiTimeoutSeconds),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request interceptor for adding auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _prefs.getString(AppConstants.keyUserToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        
        // Add request ID for tracking
        options.headers['X-Request-ID'] = DateTime.now().millisecondsSinceEpoch.toString();
        
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException error, handler) {
        _handleError(error);
        handler.next(error);
      },
    ));

    // Logging interceptor (only in debug mode)
    if (!Environment.isProduction) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
        logPrint: (object) => print('[API] $object'),
      ));
    }

    // Mock interceptor for development
    if (Environment.useMockData) {
      _dio.interceptors.add(MockInterceptor());
    }

    // Retry interceptor
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      maxRetries: AppConstants.maxRetries,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 3),
      ],
    ));
  }

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          _handleUnauthorized();
          throw ServerException('Unauthorized access. Please login again.');
        } else if (statusCode == 403) {
          throw ServerException('Access forbidden. You don\'t have permission.');
        } else if (statusCode == 404) {
          throw ServerException('Resource not found.');
        } else if (statusCode != null && statusCode >= 500) {
          throw ServerException('Server error. Please try again later.');
        }
        break;
      
      case DioExceptionType.cancel:
        throw NetworkException('Request cancelled.');
      
      case DioExceptionType.connectionError:
        throw NetworkException('No internet connection.');
      
      default:
        throw NetworkException('Unexpected error occurred.');
    }
  }

  void _handleUnauthorized() {
    // Clear stored token
    _prefs.remove(AppConstants.keyUserToken);
    _prefs.setBool(AppConstants.keyIsLoggedIn, false);
    // TODO: Redirect to login (implement your navigation logic)
  }

  Dio get dio => _dio;

  // Mock data for development
  Future<Response> _getMockEmployeeData() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    final mockEmployees = [
      {
        'id': '1',
        'name': 'John Doe',
        'email': 'john.doe@company.com',
        'department': 'Engineering',
        'position': 'Senior Developer',
        'phoneNumber': '+1234567890',
        'avatarUrl': null,
        'isActive': true,
        'isClockedIn': true,
        'lastClockIn': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        'lastClockOut': null,
        'hireDate': DateTime.now().subtract(const Duration(days: 365)).toIso8601String(),
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'email': 'jane.smith@company.com',
        'department': 'Marketing',
        'position': 'Marketing Manager',
        'phoneNumber': '+1234567891',
        'avatarUrl': null,
        'isActive': true,
        'isClockedIn': false,
        'lastClockIn': null,
        'lastClockOut': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
        'hireDate': DateTime.now().subtract(const Duration(days: 180)).toIso8601String(),
      },
      {
        'id': '3',
        'name': 'Bob Johnson',
        'email': 'bob.johnson@company.com',
        'department': 'Sales',
        'position': 'Sales Representative',
        'phoneNumber': '+1234567892',
        'avatarUrl': null,
        'isActive': true,
        'isClockedIn': true,
        'lastClockIn': DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
        'lastClockOut': null,
        'hireDate': DateTime.now().subtract(const Duration(days: 90)).toIso8601String(),
      },
    ];

    return Response(
      data: {'data': mockEmployees, 'success': true, 'message': 'Mock data loaded successfully'},
      statusCode: 200,
      requestOptions: RequestOptions(path: '/employees'),
    );
  }
}

// FIXED Retry interceptor
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final List<Duration> retryDelays;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    required this.retryDelays,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = RetryOptions.fromExtra(err.requestOptions) ?? RetryOptions(retries: maxRetries);

    if (extra.retries > 0 && _shouldRetry(err)) {
      final delay = retryDelays[maxRetries - extra.retries];
      await Future.delayed(delay);

      // Create new RetryOptions with decremented retries
      final newRetries = extra.retries - 1;
      final newOptions = RetryOptions(retries: newRetries);
      err.requestOptions.extra = err.requestOptions.extra..addAll(newOptions.toExtra());

      try {
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        super.onError(err, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           (err.type == DioExceptionType.badResponse && 
            err.response?.statusCode != null && 
            err.response!.statusCode! >= 500);
  }
}

// FIXED RetryOptions class
class RetryOptions {
  final int retries;

  RetryOptions({required this.retries});

  static RetryOptions? fromExtra(RequestOptions request) {
    final retriesValue = request.extra['retries'];
    return retriesValue != null ? RetryOptions(retries: retriesValue) : null;
  }

  Map<String, dynamic> toExtra() => {'retries': retries};
}

// Mock interceptor for development
class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Return mock data instead of making real HTTP requests
    if (options.path.contains('/employees')) {
      // Simulate network delay
      Future.delayed(const Duration(milliseconds: 500), () {
        final mockEmployees = [
          {
            'id': '1',
            'name': 'John Doe',
            'email': 'john.doe@company.com',
            'department': 'Engineering',
            'position': 'Senior Developer',
            'phoneNumber': '+1234567890',
            'avatarUrl': null,
            'isActive': true,
            'isClockedIn': true,
            'lastClockIn': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
            'lastClockOut': null,
            'hireDate': DateTime.now().subtract(const Duration(days: 365)).toIso8601String(),
          },
          {
            'id': '2',
            'name': 'Jane Smith',
            'email': 'jane.smith@company.com',
            'department': 'Marketing',
            'position': 'Marketing Manager',
            'phoneNumber': '+1234567891',
            'avatarUrl': null,
            'isActive': true,
            'isClockedIn': false,
            'lastClockIn': null,
            'lastClockOut': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
            'hireDate': DateTime.now().subtract(const Duration(days: 180)).toIso8601String(),
          },
          {
            'id': '3',
            'name': 'Bob Johnson',
            'email': 'bob.johnson@company.com',
            'department': 'Sales',
            'position': 'Sales Representative',
            'phoneNumber': '+1234567892',
            'avatarUrl': null,
            'isActive': true,
            'isClockedIn': true,
            'lastClockIn': DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
            'lastClockOut': null,
            'hireDate': DateTime.now().subtract(const Duration(days: 90)).toIso8601String(),
          },
        ];

        final response = Response(
          data: {'data': mockEmployees, 'success': true, 'message': 'Mock data loaded successfully'},
          statusCode: 200,
          requestOptions: options,
        );

        handler.resolve(response);
      });
    } else {
      // For other endpoints, continue with normal request
      handler.next(options);
    }
  }
}
