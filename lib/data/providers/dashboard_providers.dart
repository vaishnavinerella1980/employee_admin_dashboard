// lib/data/providers/dashboard_providers.dart
import 'package:employee_admin_dashboard/domain/employee/get_all_employees.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/employee_entity.dart';
import '../../config/dependency_injection.dart';

final dashboardProvider =
    AsyncNotifierProvider<DashboardNotifier, DashboardData>(() {
  return DashboardNotifier();
});

class DashboardNotifier extends AsyncNotifier<DashboardData> {
  late final GetAllEmployees _getAllEmployees;

  @override
  Future<DashboardData> build() async {
    _getAllEmployees = getIt<GetAllEmployees>();

    // Return initial empty state instead of auto-loading
    return DashboardData(
      totalEmployees: 0,
      activeEmployees: 0,
      clockedInEmployees: 0,
      onBreakEmployees: 0,
      overtimeEmployees: 0,
      employeeTrend: 0.0,
      clockedInTrend: 0.0,
      breakTrend: 0.0,
      overtimeTrend: 0.0,
      recentActivities: [],
    );
  }

  Future<DashboardData> loadDashboardData() async {
    try {
      // Load employees
      final employeesResult = await _getAllEmployees();

      return employeesResult.fold(
        (failure) {
          throw Exception('Failed to load employee data: ${failure.message}');
        },
        (employees) {
          // Create dashboard data with just employee data
          final dashboardData = DashboardData.fromEmployees(employees);
          return dashboardData;
        },
      );
    } catch (e) {
      throw Exception('Unexpected error loading dashboard: $e');
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final data = await loadDashboardData();
      state = AsyncData(data);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  // Method to manually trigger error for testing
  void simulateError() {
    state = AsyncError(
      'Simulated error for testing',
      StackTrace.current,
    );
  }

  // Method to reset to loading state
  void setLoading() {
    state = const AsyncLoading();
  }
}

class DashboardData {
  final int totalEmployees;
  final int activeEmployees;
  final int clockedInEmployees;
  final int onBreakEmployees;
  final int overtimeEmployees;
  final double employeeTrend;
  final double clockedInTrend;
  final double breakTrend;
  final double overtimeTrend;
  final List<ActivityData> recentActivities;

  DashboardData({
    required this.totalEmployees,
    required this.activeEmployees,
    required this.clockedInEmployees,
    required this.onBreakEmployees,
    required this.overtimeEmployees,
    required this.employeeTrend,
    required this.clockedInTrend,
    required this.breakTrend,
    required this.overtimeTrend,
    required this.recentActivities,
  });

  factory DashboardData.fromEmployees(
    List<EmployeeEntity> employees, {
    Map<String, dynamic>? additionalStats,
  }) {
    final total = employees.length;
    final active = employees.where((e) => e.isActive).length;
    final clockedIn = employees.where((e) => e.isClockedIn).length;

    // Use additional stats if available, otherwise calculate or use defaults
    int onBreak = 0;
    int overtime = 0;
    double employeeTrend = 5.2;
    double clockedInTrend = -2.1;
    double breakTrend = 0.0;
    double overtimeTrend = 8.7;
    List<ActivityData> activities = [];

    if (additionalStats != null) {
      onBreak = additionalStats['onBreakEmployees'] ?? 0;
      overtime = additionalStats['overtimeEmployees'] ?? 0;
      employeeTrend = additionalStats['employeeTrend']?.toDouble() ?? 5.2;
      clockedInTrend = additionalStats['clockedInTrend']?.toDouble() ?? -2.1;
      breakTrend = additionalStats['breakTrend']?.toDouble() ?? 0.0;
      overtimeTrend = additionalStats['overtimeTrend']?.toDouble() ?? 8.7;

      // Parse recent activities
      final rawActivities =
          additionalStats['recentActivities'] as List<Map<String, dynamic>>?;
      if (rawActivities != null) {
        activities = rawActivities
            .map((activity) => ActivityData(
                  id: activity['id'] ?? '',
                  employeeId: activity['employeeId'] ?? '',
                  employeeName: activity['employeeName'] ?? 'Unknown',
                  message: activity['description'] ?? 'Unknown activity',
                  timestamp: activity['timestamp'] ?? DateTime.now(),
                  type: _parseActivityType(activity['type']),
                ))
            .toList();
      }
    }

    // If no activities from additional stats, generate some from employees
    if (activities.isEmpty) {
      activities = _generateActivitiesFromEmployees(employees);
    }

    return DashboardData(
      totalEmployees: total,
      activeEmployees: active,
      clockedInEmployees: clockedIn,
      onBreakEmployees: onBreak,
      overtimeEmployees: overtime,
      employeeTrend: employeeTrend,
      clockedInTrend: clockedInTrend,
      breakTrend: breakTrend,
      overtimeTrend: overtimeTrend,
      recentActivities: activities,
    );
  }

  static ActivityType _parseActivityType(String? type) {
    switch (type?.toLowerCase()) {
      case 'clock_in':
        return ActivityType.clockIn;
      case 'clock_out':
        return ActivityType.clockOut;
      case 'break_start':
      case 'break_end':
        return ActivityType.break_;
      case 'overtime':
        return ActivityType.overtime;
      default:
        return ActivityType.system;
    }
  }

  static List<ActivityData> _generateActivitiesFromEmployees(
      List<EmployeeEntity> employees) {
    final activities = <ActivityData>[];
    final now = DateTime.now();

    // Generate activities from employee clock-in/out data
    for (int i = 0; i < employees.length.clamp(0, 5); i++) {
      final employee = employees[i];

      if (employee.isClockedIn && employee.lastClockIn != null) {
        activities.add(ActivityData(
          id: 'activity_${employee.id}_clockin',
          employeeId: employee.id,
          employeeName: employee.name,
          message: '${employee.name} clocked in',
          timestamp: employee.lastClockIn!,
          type: ActivityType.clockIn,
        ));
      } else if (!employee.isClockedIn && employee.lastClockOut != null) {
        activities.add(ActivityData(
          id: 'activity_${employee.id}_clockout',
          employeeId: employee.id,
          employeeName: employee.name,
          message: '${employee.name} clocked out',
          timestamp: employee.lastClockOut!,
          type: ActivityType.clockOut,
        ));
      }
    }

    // Sort by timestamp (most recent first)
    activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // If still no activities, generate some sample ones
    if (activities.isEmpty && employees.isNotEmpty) {
      activities.add(ActivityData(
        id: 'sample_activity',
        employeeId: employees.first.id,
        employeeName: employees.first.name,
        message: 'System initialized',
        timestamp: now.subtract(const Duration(minutes: 5)),
        type: ActivityType.system,
      ));
    }

    return activities.take(10).toList(); // Limit to 10 activities
  }

  // Helper method to get summary statistics
  Map<String, dynamic> getSummaryStats() {
    return {
      'totalEmployees': totalEmployees,
      'activeEmployees': activeEmployees,
      'clockedInEmployees': clockedInEmployees,
      'onBreakEmployees': onBreakEmployees,
      'overtimeEmployees': overtimeEmployees,
      'clockedOutEmployees': activeEmployees - clockedInEmployees,
      'inactiveEmployees': totalEmployees - activeEmployees,
    };
  }

  // Helper method to check if data indicates healthy operations
  bool get isHealthyStatus {
    return totalEmployees > 0 &&
        activeEmployees > 0 &&
        (clockedInEmployees / activeEmployees.clamp(1, double.infinity)) > 0.5;
  }
}

class ActivityData {
  final String id;
  final String employeeId;
  final String employeeName;
  final String message;
  final DateTime timestamp;
  final ActivityType type;

  ActivityData({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.message,
    required this.timestamp,
    required this.type,
  });

  // Helper to get a user-friendly time description
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

enum ActivityType {
  clockIn,
  clockOut,
  break_,
  overtime,
  system,
}
