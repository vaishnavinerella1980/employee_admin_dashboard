import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl =
      'YOUR_API_BASE_URL'; // Replace with your actual URL
  static String? _authToken;
  static const Duration timeoutDuration = Duration(seconds: 30);

  // FIXED: Proper response handler that prevents LinkedMap issues
  static Map<String, dynamic> _handleResponse(http.Response response) {
    debugPrint('=== API Response Debug ===');
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);

        // FIX: Convert LinkedMap to proper Map<String, dynamic>
        if (decoded is Map) {
          return _safeMapConversion(decoded);
        } else if (decoded is List) {
          return {
            'success': true,
            'data': decoded
                .map((item) => item is Map ? _safeMapConversion(item) : item)
                .toList(),
          };
        } else {
          return {
            'success': true,
            'data': decoded,
          };
        }
      } else {
        // Handle error responses
        try {
          final dynamic errorData = jsonDecode(response.body);
          return {
            'success': false,
            'statusCode': response.statusCode,
            'message': errorData is Map
                ? errorData['message'] ?? 'Unknown error'
                : 'Error occurred',
            'error': errorData,
          };
        } catch (e) {
          return {
            'success': false,
            'statusCode': response.statusCode,
            'message': 'HTTP ${response.statusCode}: ${response.reasonPhrase}',
            'error': response.body,
          };
        }
      }
    } catch (e) {
      debugPrint('JSON Parse Error: $e');
      return {
        'success': false,
        'message': 'Failed to parse response: $e',
        'error': response.body,
      };
    }
  }

  // CRITICAL FIX: Safe map conversion to prevent LinkedMap issues
  static Map<String, dynamic> _safeMapConversion(Map input) {
    final Map<String, dynamic> result = {};
    input.forEach((key, value) {
      String stringKey = key.toString();
      if (value is Map) {
        result[stringKey] = _safeMapConversion(value);
      } else if (value is List) {
        result[stringKey] = value
            .map((item) => item is Map ? _safeMapConversion(item) : item)
            .toList();
      } else {
        result[stringKey] = value;
      }
    });
    return result;
  }

  static Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  // FIXED: Login method
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('=== LOGIN REQUEST ===');
      debugPrint('Email: $email');

      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: _getHeaders(),
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(timeoutDuration);

      final result = _handleResponse(response);

      // Store auth token if login successful
      if (result['success'] == true && result['data'] != null) {
        final data = result['data'];
        if (data is Map && data.containsKey('token')) {
          _authToken = data['token'].toString();
          debugPrint('Auth token stored successfully');
        }
      }

      return result;
    } catch (e) {
      debugPrint('Login error: $e');
      return {
        'success': false,
        'message': 'Login failed: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  // FIXED: Get employees method
  static Future<Map<String, dynamic>> getEmployees({
    int page = 1,
    int limit = 50,
    String? department,
    String? search,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (department != null && department.isNotEmpty) {
        queryParams['department'] = department;
      }

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final uri = Uri.parse('$baseUrl/employees').replace(
        queryParameters: queryParams,
      );

      final response =
          await http.get(uri, headers: _getHeaders()).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Get employees error: $e');
      return {
        'success': false,
        'message': 'Failed to load employees: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  // FIXED: Get attendance method
  static Future<Map<String, dynamic>> getAttendance({
    String? employeeId,
    String? date,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (employeeId != null && employeeId.isNotEmpty) {
        queryParams['employeeId'] = employeeId;
      }

      if (date != null && date.isNotEmpty) {
        queryParams['date'] = date;
      }

      final uri = Uri.parse('$baseUrl/attendance').replace(
        queryParameters: queryParams,
      );

      final response =
          await http.get(uri, headers: _getHeaders()).timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Get attendance error: $e');
      return {
        'success': false,
        'message': 'Failed to load attendance: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  // FIXED: Create employee method
  static Future<Map<String, dynamic>> createEmployee({
    required Map<String, dynamic> employeeData,
  }) async {
    try {
      // Ensure data is properly formatted
      final safeData = _safeMapConversion(employeeData);

      final response = await http
          .post(
            Uri.parse('$baseUrl/employees'),
            headers: _getHeaders(),
            body: jsonEncode(safeData),
          )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Create employee error: $e');
      return {
        'success': false,
        'message': 'Failed to create employee: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  // FIXED: Update employee method
  static Future<Map<String, dynamic>> updateEmployee({
    required Map<String, dynamic> employeeData,
  }) async {
    try {
      // Ensure data is properly formatted
      final safeData = _safeMapConversion(employeeData);

      final response = await http
          .put(
            Uri.parse('$baseUrl/employees/profile'), // Use profile endpoint
            headers: _getHeaders(),
            body: jsonEncode(safeData),
          )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Update employee error: $e');
      return {
        'success': false,
        'message': 'Failed to update employee: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  // FIXED: Delete employee method
  static Future<Map<String, dynamic>> deleteEmployee({
    required String employeeId,
  }) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$baseUrl/employees/$employeeId'),
            headers: _getHeaders(),
          )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Delete employee error: $e');
      return {
        'success': false,
        'message': 'Failed to delete employee: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  // Utility method to clear auth token
  static void clearAuth() {
    _authToken = null;
  }

  // Utility method to set auth token
  static void setAuthToken(String token) {
    _authToken = token;
  }

  // Check if user is authenticated
  static bool get isAuthenticated => _authToken != null;

  // Reports API methods (mock implementations)
  static Future<Map<String, dynamic>> getReports() async {
    try {
      // Mock implementation - in real app, this would call the API
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate network delay
      return {
        'success': true,
        'data': [], // Reports will be generated locally in the notifier
        'message': 'Reports loaded successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to load reports: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> generateReport({
    required String reportType,
    required String period,
    DateTime? fromDate,
    DateTime? toDate,
    String? department,
  }) async {
    try {
      // Mock implementation - in real app, this would send data to API
      await Future.delayed(
          const Duration(milliseconds: 1000)); // Simulate processing delay
      return {
        'success': true,
        'message': 'Report generated successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to generate report: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> downloadReport(String reportId) async {
    try {
      // Mock implementation - in real app, this would download the file
      await Future.delayed(
          const Duration(milliseconds: 800)); // Simulate download delay
      return {
        'success': true,
        'message': 'Report downloaded successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to download report: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> deleteReport(String reportId) async {
    try {
      // Mock implementation - in real app, this would delete from API
      await Future.delayed(
          const Duration(milliseconds: 300)); // Simulate delete delay
      return {
        'success': true,
        'message': 'Report deleted successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to delete report: ${e.toString()}',
        'error': e.toString(),
      };
    }
  }
}
