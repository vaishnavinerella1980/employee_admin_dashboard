// lib/config/environment.dart
class Environment {
  static late String _baseUrl;
  static late bool _isProduction;
  static late bool _useMockData;

  static String get baseUrl => _baseUrl;
  static bool get isProduction => _isProduction;
  static bool get isDevelopment => !_isProduction;
  static bool get useMockData => _useMockData;

  static Future<void> initialize() async {
    // Set environment variables based on build mode or flavor
    const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
    const useMock = String.fromEnvironment('USE_MOCK_DATA', defaultValue: 'true');
    
    _isProduction = environment == 'production';
    _useMockData = useMock.toLowerCase() == 'true' || isDevelopment;

    if (_isProduction) {
      _baseUrl = 'https://api.yourcompany.com'; // Replace with your production API
      _useMockData = false; // Never use mock data in production
    } else {
      // Development environment
      _baseUrl = 'https://dev-api.yourcompany.com'; // This will be ignored if using mock data
      
      // For development, we default to using mock data unless explicitly disabled
      if (_useMockData) {
        // Running in development mode with MOCK DATA
        // All API calls will use local mock services
        // To use real API, run with: flutter run --dart-define=USE_MOCK_DATA=false
      } else {
        // Running in development mode with REAL API
        // API Base URL: $_baseUrl
      }
    }

    // Environment initialized
    // - Production: $_isProduction
    // - Base URL: $_baseUrl
    // - Use Mock Data: $_useMockData
  }

  // Alternative: Set environment manually for different build configurations
  static void setEnvironment({
    required bool isProduction,
    required String baseUrl,
    bool? useMockData,
  }) {
    _isProduction = isProduction;
    _baseUrl = baseUrl;
    _useMockData = useMockData ?? (!isProduction);
    
    // Environment manually configured
    // - Production: $_isProduction
    // - Base URL: $_baseUrl
    // - Use Mock Data: $_useMockData
  }

  // Helper method to determine if we should use mock services
  static bool shouldUseMockServices() {
    return _useMockData || isDevelopment;
  }

  // Get appropriate service configuration
  static Map<String, dynamic> getServiceConfig() {
    return {
      'baseUrl': _baseUrl,
      'isProduction': _isProduction,
      'useMockData': _useMockData,
      'timeout': _isProduction ? 30000 : 10000, // Production gets longer timeout
      'retries': _isProduction ? 3 : 1,
      'enableLogging': isDevelopment,
    };
  }
}