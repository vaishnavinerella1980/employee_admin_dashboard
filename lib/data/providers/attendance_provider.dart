import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

// ========================================
// ATTENDANCE RECORD MODEL (if not imported)
// ========================================

class AttendanceRecord {
  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime loginTime;
  final DateTime? logoutTime;
  final bool isActive;
  final String? loginAddress;
  final String? logoutAddress;
  final String? reason;
  final Duration? workDuration;

  AttendanceRecord({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.loginTime,
    this.logoutTime,
    required this.isActive,
    this.loginAddress,
    this.logoutAddress,
    this.reason,
    this.workDuration,
  });

  // FIXED: Safe fromJson that handles LinkedMap
  factory AttendanceRecord.fromJson(dynamic json) {
    try {
      // Convert any Map type to Map<String, dynamic>
      final Map<String, dynamic> data = _safeMapConversion(json);

      final loginTime = _safeDateTime(data['loginTime']) ?? DateTime.now();
      final logoutTime = _safeDateTime(data['logoutTime']);

      // Calculate work duration if both login and logout times exist
      Duration? workDuration;
      if (logoutTime != null) {
        workDuration = logoutTime.difference(loginTime);
      }

      return AttendanceRecord(
        id: _safeString(data['_id'] ?? data['id']),
        employeeId: _safeString(data['employeeId']),
        employeeName:
            _safeString(data['employeeName'] ?? data['employee']?['name']),
        loginTime: loginTime,
        logoutTime: logoutTime,
        isActive: data['isActive'] == true,
        loginAddress: _safeStringNullable(data['loginAddress']),
        logoutAddress: _safeStringNullable(data['logoutAddress']),
        reason: _safeStringNullable(data['reason']),
        workDuration: workDuration,
      );
    } catch (e) {
      throw Exception('Failed to parse AttendanceRecord from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'loginTime': loginTime.toIso8601String(),
      'logoutTime': logoutTime?.toIso8601String(),
      'isActive': isActive,
      'loginAddress': loginAddress,
      'logoutAddress': logoutAddress,
      'reason': reason,
      'workDuration': workDuration?.inMinutes,
    };
  }

  // Helper method to get formatted duration
  String get formattedDuration {
    final duration = workDuration ??
        (isActive ? DateTime.now().difference(loginTime) : Duration.zero);

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  AttendanceRecord copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    DateTime? loginTime,
    DateTime? logoutTime,
    bool? isActive,
    String? loginAddress,
    String? logoutAddress,
    String? reason,
    Duration? workDuration,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      loginTime: loginTime ?? this.loginTime,
      logoutTime: logoutTime ?? this.logoutTime,
      isActive: isActive ?? this.isActive,
      loginAddress: loginAddress ?? this.loginAddress,
      logoutAddress: logoutAddress ?? this.logoutAddress,
      reason: reason ?? this.reason,
      workDuration: workDuration ?? this.workDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AttendanceRecord && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AttendanceRecord(id: $id, employeeName: $employeeName, isActive: $isActive)';
  }
}

// ========================================
// ATTENDANCE STATE
// ========================================

class AttendanceState {
  final List<AttendanceRecord> records;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;

  AttendanceState({
    required this.records,
    required this.isLoading,
    this.error,
    this.lastUpdated,
  });

  AttendanceState copyWith({
    List<AttendanceRecord>? records,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return AttendanceState(
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AttendanceState &&
        other.records.length == records.length &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(records.length, isLoading, error);

  @override
  String toString() {
    return 'AttendanceState(records: ${records.length}, isLoading: $isLoading, error: $error)';
  }
}

// ========================================
// MOCK API SERVICE (replace with your actual service)
// ========================================

class ApiService {
  static Future<Map<String, dynamic>> getAttendance({
    String? employeeId,
    String? date,
    int page = 1,
    int limit = 50,
  }) async {
    // MOCK DATA - Replace with your actual API call
    await Future.delayed(const Duration(seconds: 1));

    return {
      'success': true,
      'data': {
        'attendance': [
          {
            '_id': '1',
            'employeeId': 'emp1',
            'employeeName': 'John Doe',
            'loginTime': DateTime.now()
                .subtract(const Duration(hours: 8))
                .toIso8601String(),
            'logoutTime': null,
            'isActive': true,
            'loginAddress': '123 Main St',
            'reason': null,
          },
          {
            '_id': '2',
            'employeeId': 'emp2',
            'employeeName': 'Jane Smith',
            'loginTime': DateTime.now()
                .subtract(const Duration(hours: 6))
                .toIso8601String(),
            'logoutTime': DateTime.now()
                .subtract(const Duration(hours: 1))
                .toIso8601String(),
            'isActive': false,
            'loginAddress': '456 Oak Ave',
            'logoutAddress': '456 Oak Ave',
            'reason': null,
          },
        ],
      },
    };
  }
}

// ========================================
// ATTENDANCE NOTIFIER
// ========================================

class AttendanceNotifier extends Notifier<AttendanceState> {
  AttendanceNotifier();

  @override
  AttendanceState build() => AttendanceState(records: [], isLoading: false);

  Future<void> loadAttendance({
    String? employeeId,
    String? date,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      debugPrint('=== Loading Attendance ===');
      debugPrint('Employee ID: $employeeId, Date: $date');

      final response = await ApiService.getAttendance(
        employeeId: employeeId,
        date: date,
        page: page,
        limit: limit,
      );

      debugPrint('Attendance response: $response');

      if (response['success'] == true) {
        final List<AttendanceRecord> records = [];

        // FIXED: Safe data extraction and conversion
        final dynamic data = response['data'];

        if (data != null) {
          List<dynamic> recordList = [];

          // Handle different response structures
          if (data is List) {
            recordList = data;
          } else if (data is Map) {
            // Convert LinkedMap to proper Map
            final Map<String, dynamic> safeData = _safeMapConversion(data);

            // Check for nested attendance array
            if (safeData.containsKey('attendance') &&
                safeData['attendance'] is List) {
              recordList = safeData['attendance'];
            } else if (safeData.containsKey('records') &&
                safeData['records'] is List) {
              recordList = safeData['records'];
            } else if (safeData.containsKey('data') &&
                safeData['data'] is List) {
              recordList = safeData['data'];
            } else {
              // Single record case
              recordList = [safeData];
            }
          }

          // Parse each record safely
          for (final item in recordList) {
            try {
              if (item != null) {
                final record = AttendanceRecord.fromJson(item);
                records.add(record);
              }
            } catch (e) {
              debugPrint('Error parsing attendance record: $e');
              debugPrint('Item: $item');
              // Continue with other records
            }
          }
        }

        debugPrint('Successfully loaded ${records.length} attendance records');

        state = state.copyWith(
          records: records,
          isLoading: false,
          lastUpdated: DateTime.now(),
        );
      } else {
        final errorMessage =
            response['message'] ?? 'Failed to load attendance records';
        state = state.copyWith(
          isLoading: false,
          error: errorMessage,
        );
      }
    } catch (e) {
      debugPrint('Attendance loading error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load attendance: ${e.toString()}',
      );
    }
  }

  Future<void> refreshAttendance({
    String? employeeId,
    String? date,
  }) async {
    await loadAttendance(employeeId: employeeId, date: date);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearRecords() {
    state = state.copyWith(records: [], error: null);
  }

  // Add a new attendance record to the state
  void addRecord(AttendanceRecord record) {
    final updatedRecords = [...state.records, record];
    state = state.copyWith(records: updatedRecords);
  }

  // Update an existing record
  void updateRecord(AttendanceRecord updatedRecord) {
    final updatedRecords = state.records.map((record) {
      return record.id == updatedRecord.id ? updatedRecord : record;
    }).toList();
    state = state.copyWith(records: updatedRecords);
  }

  // Remove a record
  void removeRecord(String recordId) {
    final updatedRecords =
        state.records.where((record) => record.id != recordId).toList();
    state = state.copyWith(records: updatedRecords);
  }
}

// ========================================
// MAIN PROVIDERS
// ========================================

// Primary attendance provider
final attendanceProvider =
    NotifierProvider<AttendanceNotifier, AttendanceState>(
  () => AttendanceNotifier(),
);

// FIXED: Active attendance provider with proper typing
final activeAttendanceProvider = Provider<List<AttendanceRecord>>((ref) {
  final attendanceState = ref.watch(attendanceProvider);
  return attendanceState.records.where((record) => record.isActive).toList();
});

// Get attendance records for specific employee
final employeeAttendanceProvider =
    Provider.family<List<AttendanceRecord>, String>((ref, employeeId) {
  final attendanceState = ref.watch(attendanceProvider);
  return attendanceState.records
      .where((record) => record.employeeId == employeeId)
      .toList();
});

// Get attendance records for today
final todaysAttendanceProvider = Provider<List<AttendanceRecord>>((ref) {
  final attendanceState = ref.watch(attendanceProvider);
  final today = DateTime.now();

  return attendanceState.records.where((record) {
    return record.loginTime.year == today.year &&
        record.loginTime.month == today.month &&
        record.loginTime.day == today.day;
  }).toList();
});

// Get inactive (completed) attendance records
final completedAttendanceProvider = Provider<List<AttendanceRecord>>((ref) {
  final attendanceState = ref.watch(attendanceProvider);
  return attendanceState.records.where((record) => !record.isActive).toList();
});

// Get attendance statistics
final attendanceStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final attendanceState = ref.watch(attendanceProvider);
  final records = attendanceState.records;

  final totalRecords = records.length;
  final activeRecords = records.where((r) => r.isActive).length;
  final completedRecords = records.where((r) => !r.isActive).length;

  // Calculate total work hours for completed records
  final totalWorkHours = records
      .where((r) => r.workDuration != null)
      .fold<Duration>(Duration.zero,
          (sum, record) => sum + (record.workDuration ?? Duration.zero));

  return {
    'totalRecords': totalRecords,
    'activeRecords': activeRecords,
    'completedRecords': completedRecords,
    'totalWorkHours': totalWorkHours.inHours,
    'averageWorkHours':
        completedRecords > 0 ? totalWorkHours.inHours / completedRecords : 0,
  };
});

// Search attendance records
final attendanceSearchProvider =
    Provider.family<List<AttendanceRecord>, String>((ref, query) {
  final attendanceState = ref.watch(attendanceProvider);

  if (query.isEmpty) {
    return attendanceState.records;
  }

  final lowercaseQuery = query.toLowerCase();
  return attendanceState.records.where((record) {
    return record.employeeName.toLowerCase().contains(lowercaseQuery) ||
        record.employeeId.toLowerCase().contains(lowercaseQuery) ||
        (record.loginAddress?.toLowerCase().contains(lowercaseQuery) ?? false);
  }).toList();
});

// ========================================
// UTILITY FUNCTIONS
// ========================================

// CRITICAL: Safe map conversion to prevent LinkedMap issues
Map<String, dynamic> _safeMapConversion(dynamic input) {
  if (input is Map<String, dynamic>) {
    return input;
  } else if (input is Map) {
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
  } else {
    throw ArgumentError('Expected Map, got ${input.runtimeType}');
  }
}

// Safe string conversion
String _safeString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

String? _safeStringNullable(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

// Safe DateTime conversion
DateTime? _safeDateTime(dynamic value) {
  if (value == null) return null;

  try {
    if (value is DateTime) return value;
    if (value is String) return DateTime.parse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  } catch (e) {
    debugPrint('Error parsing DateTime: $e');
    return null;
  }
}
