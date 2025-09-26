import 'package:employee_admin_dashboard/data/api_service.dart';
import 'package:employee_admin_dashboard/data/models/data_models.dart'
    as data_models;
import 'package:employee_admin_dashboard/data/models/employee.dart'
    as employee_model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

// Import your models and services (adjust paths as needed)
// import 'fixed_api_service.dart';
// import 'fixed_data_models.dart';

// ========================================
// EMPLOYEE STATE MANAGEMENT
// ========================================

class EmployeeState {
  final List<employee_model.Employee> employees;
  final bool isLoading;
  final String? error;

  EmployeeState({
    required this.employees,
    required this.isLoading,
    this.error,
  });

  EmployeeState copyWith({
    List<employee_model.Employee>? employees,
    bool? isLoading,
    String? error,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// FIXED: Employee provider with proper LinkedMap handling
class EmployeeNotifier extends Notifier<EmployeeState> {
  @override
  EmployeeState build() {
    return EmployeeState(employees: [], isLoading: false);
  }

  Future<void> loadEmployees({
    int page = 1,
    int limit = 50,
    String? department,
    String? search,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      debugPrint('=== Loading Employees ===');
      debugPrint('Page: $page, Limit: $limit');
      debugPrint('Department: $department, Search: $search');

      final response = await ApiService.getEmployees(
        page: page,
        limit: limit,
        department: department,
        search: search,
      );

      debugPrint('Employee response: $response');

      if (response['success'] == true) {
        final List<employee_model.Employee> employees = [];

        // FIXED: Safe data extraction and conversion
        final dynamic data = response['data'];

        if (data != null) {
          List<dynamic> employeeList = [];

          // Handle different response structures
          if (data is List) {
            employeeList = data;
          } else if (data is Map) {
            // Convert LinkedMap to proper Map
            final Map<String, dynamic> safeData =
                Map<String, dynamic>.from(data);

            // Check for nested employees array
            if (safeData.containsKey('employees') &&
                safeData['employees'] is List) {
              employeeList = safeData['employees'];
            } else if (safeData.containsKey('data') &&
                safeData['data'] is List) {
              employeeList = safeData['data'];
            } else {
              // Single employee case
              employeeList = [safeData];
            }
          }

          // Parse each employee safely
          for (final item in employeeList) {
            try {
              if (item != null) {
                final employee = employee_model.Employee.fromJson(item);
                employees.add(employee);
              }
            } catch (e) {
              debugPrint('Error parsing employee item: $e');
              debugPrint('Item: $item');
              // Continue with other employees
            }
          }
        }

        debugPrint('Successfully loaded ${employees.length} employees');

        state = state.copyWith(
          employees: employees,
          isLoading: false,
        );
      } else {
        final errorMessage = response['message'] ?? 'Failed to load employees';
        state = state.copyWith(
          isLoading: false,
          error: errorMessage,
        );
      }
    } catch (e) {
      debugPrint('Employee loading error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load employees: ${e.toString()}',
      );
    }
  }

  Future<void> createEmployee(Map<String, dynamic> employeeData) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Ensure data is safe for JSON encoding
      final safeData = _safeMapConversion(employeeData);

      final response = await ApiService.createEmployee(employeeData: safeData);

      if (response['success'] == true) {
        // Reload employees list
        await loadEmployees();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to create employee',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to create employee: ${e.toString()}',
      );
    }
  }

  Future<void> updateEmployee(
      String employeeId, Map<String, dynamic> employeeData) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Ensure data is safe for JSON encoding
      final safeData = _safeMapConversion(employeeData);

      final response = await ApiService.updateEmployee(employeeData: safeData);

      if (response['success'] == true) {
        // Reload employees list
        await loadEmployees();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to update employee',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update employee: ${e.toString()}',
      );
    }
  }

  Future<void> deleteEmployee(String employeeId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response = await ApiService.deleteEmployee(employeeId: employeeId);

      if (response['success'] == true) {
        // Remove employee from local state
        final updatedEmployees =
            state.employees.where((emp) => emp.id != employeeId).toList();

        state = state.copyWith(
          employees: updatedEmployees,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to delete employee',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to delete employee: ${e.toString()}',
      );
    }
  }
}

final employeeProvider = NotifierProvider<EmployeeNotifier, EmployeeState>(
  () => EmployeeNotifier(),
);

// ========================================
// ATTENDANCE STATE MANAGEMENT
// ========================================

class AttendanceState {
  final List<data_models.AttendanceRecord> records;
  final bool isLoading;
  final String? error;

  AttendanceState({
    required this.records,
    required this.isLoading,
    this.error,
  });

  AttendanceState copyWith({
    List<data_models.AttendanceRecord>? records,
    bool? isLoading,
    String? error,
  }) {
    return AttendanceState(
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// FIXED: Attendance provider with proper LinkedMap handling
class AttendanceNotifier extends Notifier<AttendanceState> {
  @override
  AttendanceState build() {
    return AttendanceState(records: [], isLoading: false);
  }

  Future<void> loadAttendance({
    String? employeeId,
    String? date,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response = await ApiService.getAttendance(
        employeeId: employeeId,
        date: date,
        page: page,
        limit: limit,
      );

      if (response['success'] == true) {
        final List<data_models.AttendanceRecord> records = [];

        // FIXED: Safe data extraction and conversion
        final dynamic data = response['data'];

        if (data != null) {
          List<dynamic> recordList = [];

          // Handle different response structures
          if (data is List) {
            recordList = data;
          } else if (data is Map) {
            // Convert LinkedMap to proper Map
            final Map<String, dynamic> safeData =
                Map<String, dynamic>.from(data);

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
                final record = data_models.AttendanceRecord.fromJson(item);
                records.add(record);
              }
            } catch (e) {
              debugPrint('Error parsing attendance record: $e');
              // Continue with other records
            }
          }
        }

        state = state.copyWith(
          records: records,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load attendance records',
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

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final attendanceProvider = NotifierProvider<AttendanceNotifier, AttendanceState>(
  () => AttendanceNotifier(),
);

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

// ========================================
// COMPUTED PROVIDERS
// ========================================

// Get active employees only
final activeEmployeesProvider = Provider<List<employee_model.Employee>>((ref) {
  final employeeState = ref.watch(employeeProvider);
  return employeeState.employees.where((emp) => emp.isActive).toList();
});

// Get employees by department
final employeesByDepartmentProvider =
    Provider.family<List<employee_model.Employee>, String?>((ref, department) {
  final employeeState = ref.watch(employeeProvider);

  if (department == null || department.isEmpty || department == 'All') {
    return employeeState.employees;
  }

  return employeeState.employees
      .where((emp) => emp.department?.toLowerCase() == department.toLowerCase())
      .toList();
});

// Get active attendance records
final activeAttendanceProvider =
    Provider<List<data_models.AttendanceRecord>>((ref) {
  final attendanceState = ref.watch(attendanceProvider);
  return attendanceState.records.where((record) => record.isActive).toList();
});

// Get attendance records for specific employee
final employeeAttendanceProvider =
    Provider.family<List<data_models.AttendanceRecord>, String>(
        (ref, employeeId) {
  final attendanceState = ref.watch(attendanceProvider);
  return attendanceState.records
      .where((record) => record.employeeId == employeeId)
      .toList();
});
