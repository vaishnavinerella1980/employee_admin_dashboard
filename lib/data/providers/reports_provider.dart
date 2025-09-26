import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:employee_admin_dashboard/data/models/report.dart';
import 'package:employee_admin_dashboard/data/providers/riverpod_providers.dart' as rp;
import 'package:employee_admin_dashboard/data/models/employee.dart' as employee_model;
import 'package:employee_admin_dashboard/data/models/data_models.dart' as data_models;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// ========================================
// REPORTS STATE
// ========================================

class ReportsState {
  final List<Report> reports;
  final bool isLoading;
  final String? error;
  final bool isGeneratingReport;

  ReportsState({
    required this.reports,
    required this.isLoading,
    this.error,
    this.isGeneratingReport = false,
  });

  ReportsState copyWith({
    List<Report>? reports,
    bool? isLoading,
    String? error,
    bool? isGeneratingReport,
  }) {
    return ReportsState(
      reports: reports ?? this.reports,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isGeneratingReport: isGeneratingReport ?? this.isGeneratingReport,
    );
  }
}

// ========================================
// REPORTS NOTIFIER
// ========================================

class ReportsNotifier extends Notifier<ReportsState> {
  @override
  ReportsState build() {
    return ReportsState(reports: [], isLoading: false);
  }

  Future<void> loadReports() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // For now, we'll use mock data. In a real app, this would load from a database or API
      final mockReports = await _getMockReports();

      state = state.copyWith(
        reports: mockReports,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load reports: ${e.toString()}',
      );
    }
  }

  Future<void> generateReport({
    required String reportType,
    required String period,
    DateTime? fromDate,
    DateTime? toDate,
    String? department,
  }) async {
    try {
      state = state.copyWith(isGeneratingReport: true, error: null);

      // Get data from other providers
      final attendanceRecords = ref.read(rp.attendanceProvider).records;
      final employees = ref.read(rp.employeeProvider).employees;

      // Generate report data based on type
      final reportData = await _generateReportData(
        reportType: reportType,
        period: period,
        fromDate: fromDate,
        toDate: toDate,
        department: department,
        attendanceRecords: attendanceRecords,
        employees: employees,
      );

      // Create report file
      final report = await _createReportFile(reportData);

      // Add to reports list
      final updatedReports = [report, ...state.reports];
      state = state.copyWith(
        reports: updatedReports,
        isGeneratingReport: false,
      );

      debugPrint('Report generated successfully: ${report.name}');
    } catch (e) {
      state = state.copyWith(
        isGeneratingReport: false,
        error: 'Failed to generate report: ${e.toString()}',
      );
    }
  }

  Future<void> downloadReport(String reportId) async {
    try {
      final report = state.reports.firstWhere((r) => r.id == reportId);

      // In a real app, this would download from a server
      // For now, we'll just show the file exists
      final file = File(report.filePath);
      if (await file.exists()) {
        debugPrint('Report downloaded: ${report.filePath}');
      } else {
        throw Exception('Report file not found');
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to download report: ${e.toString()}');
    }
  }

  Future<void> shareReport(String reportId) async {
    try {
      final report = state.reports.firstWhere((r) => r.id == reportId);

      // In a real app, this would share the file
      // For now, we'll just show a message
      debugPrint('Sharing report: ${report.name}');
    } catch (e) {
      state = state.copyWith(error: 'Failed to share report: ${e.toString()}');
    }
  }

  Future<void> deleteReport(String reportId) async {
    try {
      final report = state.reports.firstWhere((r) => r.id == reportId);

      // Delete file
      final file = File(report.filePath);
      if (await file.exists()) {
        await file.delete();
      }

      // Remove from list
      final updatedReports = state.reports.where((r) => r.id != reportId).toList();
      state = state.copyWith(reports: updatedReports);
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete report: ${e.toString()}');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  // Helper methods
  Future<List<Report>> _getMockReports() async {
    final now = DateTime.now();

    return [
      Report(
        id: 'report_001',
        name: 'Monthly Attendance Report',
        type: 'attendanceSummary',
        generatedAt: now.subtract(const Duration(days: 1)),
        generatedBy: 'System',
        parameters: {'period': 'This Month'},
        filePath: '/mock/path/report_001.json',
        fileSize: 2457600, // 2.4 MB
        description: 'Monthly attendance summary for all employees',
      ),
      Report(
        id: 'report_002',
        name: 'Department Performance',
        type: 'departmentAnalysis',
        generatedAt: now.subtract(const Duration(days: 3)),
        generatedBy: 'Admin',
        parameters: {'department': 'All', 'period': 'This Month'},
        filePath: '/mock/path/report_002.json',
        fileSize: 1843200, // 1.8 MB
        description: 'Performance analysis by department',
      ),
      Report(
        id: 'report_003',
        name: 'Overtime Analysis',
        type: 'overtimeReport',
        generatedAt: now.subtract(const Duration(days: 5)),
        generatedBy: 'System',
        parameters: {'period': 'This Week'},
        filePath: '/mock/path/report_003.json',
        fileSize: 1228800, // 1.2 MB
        description: 'Overtime hours analysis',
      ),
    ];
  }

  Future<Map<String, dynamic>> _generateReportData({
    required String reportType,
    required String period,
    DateTime? fromDate,
    DateTime? toDate,
    String? department,
    required List<data_models.AttendanceRecord> attendanceRecords,
    required List<employee_model.Employee> employees,
  }) async {
    final now = DateTime.now();

    // Filter records based on period
    final filteredRecords = _filterRecordsByPeriod(attendanceRecords, period, fromDate, toDate);

    // Filter by department if specified
    final filteredEmployees = department != null && department != 'All'
        ? employees.where((e) => e.department == department).toList()
        : employees;

    final reportData = {
      'reportType': reportType,
      'generatedAt': now.toIso8601String(),
      'period': period,
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'department': department,
      'totalEmployees': filteredEmployees.length,
      'totalRecords': filteredRecords.length,
      'summary': _calculateSummary(filteredRecords, filteredEmployees),
      'data': _generateReportContent(reportType, filteredRecords, filteredEmployees),
    };

    return reportData;
  }

  Future<Report> _createReportFile(Map<String, dynamic> reportData) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final reportsDir = Directory('${directory.path}/reports');

      if (!await reportsDir.exists()) {
        await reportsDir.create(recursive: true);
      }

      final reportId = 'report_${DateTime.now().millisecondsSinceEpoch}';
      final filePath = '${reportsDir.path}/$reportId.json';

      final file = File(filePath);
      await file.writeAsString(jsonEncode(reportData));

      final fileSize = await file.length();

      return Report(
        id: reportId,
        name: '${reportData['reportType']} Report',
        type: reportData['reportType'],
        generatedAt: DateTime.now(),
        generatedBy: 'Current User', // In real app, get from auth
        parameters: {
          'period': reportData['period'],
          'department': reportData['department'],
          'fromDate': reportData['fromDate'],
          'toDate': reportData['toDate'],
        },
        filePath: filePath,
        fileSize: fileSize,
        description: 'Generated ${reportData['reportType']} report',
      );
    } catch (e) {
      throw Exception('Failed to create report file: $e');
    }
  }

  List<data_models.AttendanceRecord> _filterRecordsByPeriod(
    List<data_models.AttendanceRecord> records,
    String period,
    DateTime? fromDate,
    DateTime? toDate,
  ) {
    final now = DateTime.now();

    switch (period) {
      case 'Today':
        return records.where((r) =>
            r.loginTime.year == now.year &&
            r.loginTime.month == now.month &&
            r.loginTime.day == now.day).toList();

      case 'This Week':
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        return records.where((r) =>
            r.loginTime.isAfter(weekStart.subtract(const Duration(days: 1))) &&
            r.loginTime.isBefore(weekEnd.add(const Duration(days: 1)))).toList();

      case 'This Month':
        return records.where((r) =>
            r.loginTime.year == now.year &&
            r.loginTime.month == now.month).toList();

      case 'Last Month':
        final lastMonth = DateTime(now.year, now.month - 1);
        return records.where((r) =>
            r.loginTime.year == lastMonth.year &&
            r.loginTime.month == lastMonth.month).toList();

      case 'This Quarter':
        final quarterStart = DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 1);
        final quarterEnd = DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 4);
        return records.where((r) =>
            r.loginTime.isAfter(quarterStart.subtract(const Duration(days: 1))) &&
            r.loginTime.isBefore(quarterEnd)).toList();

      case 'This Year':
        return records.where((r) => r.loginTime.year == now.year).toList();

      case 'Custom Range':
        if (fromDate != null && toDate != null) {
          return records.where((r) =>
              r.loginTime.isAfter(fromDate.subtract(const Duration(days: 1))) &&
              r.loginTime.isBefore(toDate.add(const Duration(days: 1)))).toList();
        }
        return records;

      default:
        return records;
    }
  }

  Map<String, dynamic> _calculateSummary(
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    final totalHours = records
        .where((r) => r.workDuration != null)
        .fold<Duration>(Duration.zero, (sum, r) => sum + (r.workDuration ?? Duration.zero));

    final activeRecords = records.where((r) => r.isActive).length;
    final completedRecords = records.where((r) => !r.isActive).length;

    return {
      'totalRecords': records.length,
      'activeRecords': activeRecords,
      'completedRecords': completedRecords,
      'totalEmployees': employees.length,
      'totalHours': totalHours.inHours,
      'averageHoursPerEmployee': employees.isNotEmpty ? totalHours.inHours / employees.length : 0,
      'attendanceRate': records.isNotEmpty ? (completedRecords / records.length) * 100 : 0,
    };
  }

  List<Map<String, dynamic>> _generateReportContent(
    String reportType,
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    switch (reportType) {
      case 'attendanceSummary':
        return _generateAttendanceSummary(records, employees);
      case 'timeTracking':
        return _generateTimeTrackingReport(records, employees);
      case 'departmentAnalysis':
        return _generateDepartmentAnalysis(records, employees);
      case 'overtimeReport':
        return _generateOvertimeReport(records, employees);
      case 'employeePerformance':
        return _generateEmployeePerformanceReport(records, employees);
      default:
        return [];
    }
  }

  List<Map<String, dynamic>> _generateAttendanceSummary(
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    return employees.map((employee) {
      final employeeRecords = records.where((r) => r.employeeId == employee.id).toList();
      final totalHours = employeeRecords
          .where((r) => r.workDuration != null)
          .fold<Duration>(Duration.zero, (sum, r) => sum + (r.workDuration ?? Duration.zero));

      return {
        'employeeId': employee.id,
        'employeeName': employee.name,
        'department': employee.department,
        'totalRecords': employeeRecords.length,
        'totalHours': totalHours.inHours,
        'isActive': employee.isActive,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _generateTimeTrackingReport(
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    return records.map((record) {
      final employee = employees.firstWhere(
        (e) => e.id == record.employeeId,
        orElse: () => employee_model.Employee(
          id: record.employeeId,
          name: record.employeeName,
          email: '',
          department: 'Unknown',
          position: 'Unknown',
          phoneNumber: '',
          isActive: true,
          isClockedIn: record.isActive,
          hireDate: DateTime.now(),
        ),
      );

      return {
        'employeeId': record.employeeId,
        'employeeName': record.employeeName,
        'department': employee.department,
        'loginTime': record.loginTime.toIso8601String(),
        'logoutTime': record.logoutTime?.toIso8601String(),
        'isActive': record.isActive,
        'workDuration': record.workDuration?.inMinutes,
        'formattedDuration': record.formattedDuration,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _generateDepartmentAnalysis(
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    final departments = employees.map((e) => e.department).toSet().toList();

    return departments.map((dept) {
      final deptEmployees = employees.where((e) => e.department == dept).toList();
      final deptRecords = records.where((r) =>
          deptEmployees.any((e) => e.id == r.employeeId)).toList();

      final totalHours = deptRecords
          .where((r) => r.workDuration != null)
          .fold<Duration>(Duration.zero, (sum, r) => sum + (r.workDuration ?? Duration.zero));

      return {
        'department': dept,
        'totalEmployees': deptEmployees.length,
        'activeEmployees': deptEmployees.where((e) => e.isActive).length,
        'totalRecords': deptRecords.length,
        'totalHours': totalHours.inHours,
        'averageHoursPerEmployee': deptEmployees.isNotEmpty ? totalHours.inHours / deptEmployees.length : 0,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _generateOvertimeReport(
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    return records
        .where((r) => r.workDuration != null && r.workDuration!.inHours > 8)
        .map((record) {
      final employee = employees.firstWhere(
        (e) => e.id == record.employeeId,
        orElse: () => employee_model.Employee(
          id: record.employeeId,
          name: record.employeeName,
          email: '',
          department: 'Unknown',
          position: 'Unknown',
          phoneNumber: '',
          isActive: true,
          isClockedIn: record.isActive,
          hireDate: DateTime.now(),
        ),
      );

      final overtimeHours = (record.workDuration!.inHours - 8);

      return {
        'employeeId': record.employeeId,
        'employeeName': record.employeeName,
        'department': employee.department,
        'date': record.loginTime.toIso8601String().split('T')[0],
        'regularHours': 8,
        'overtimeHours': overtimeHours,
        'totalHours': record.workDuration!.inHours,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _generateEmployeePerformanceReport(
    List<data_models.AttendanceRecord> records,
    List<employee_model.Employee> employees,
  ) {
    return employees.map((employee) {
      final employeeRecords = records.where((r) => r.employeeId == employee.id).toList();
      final completedRecords = employeeRecords.where((r) => !r.isActive).toList();

      final totalHours = completedRecords
          .where((r) => r.workDuration != null)
          .fold<Duration>(Duration.zero, (sum, r) => sum + (r.workDuration ?? Duration.zero));

      final averageHours = completedRecords.isNotEmpty
          ? totalHours.inHours / completedRecords.length
          : 0;

      return {
        'employeeId': employee.id,
        'employeeName': employee.name,
        'department': employee.department,
        'position': employee.position,
        'totalRecords': employeeRecords.length,
        'completedRecords': completedRecords.length,
        'totalHours': totalHours.inHours,
        'averageHours': averageHours,
        'attendanceRate': employeeRecords.isNotEmpty
            ? (completedRecords.length / employeeRecords.length) * 100
            : 0,
        'isActive': employee.isActive,
      };
    }).toList();
  }
}

// ========================================
// PROVIDERS
// ========================================

final reportsProvider = NotifierProvider<ReportsNotifier, ReportsState>(
  () => ReportsNotifier(),
);

// Recent reports (last 10)
final recentReportsProvider = Provider<List<Report>>((ref) {
  final reportsState = ref.watch(reportsProvider);
  return reportsState.reports.take(10).toList();
});

// Reports by type
final reportsByTypeProvider = Provider.family<List<Report>, String>((ref, type) {
  final reportsState = ref.watch(reportsProvider);
  return reportsState.reports.where((report) => report.type == type).toList();
});

// Report statistics
final reportStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final reportsState = ref.watch(reportsProvider);
  final reports = reportsState.reports;

  final totalReports = reports.length;
  final thisMonthReports = reports.where((r) =>
      r.generatedAt.year == DateTime.now().year &&
      r.generatedAt.month == DateTime.now().month).length;

  final totalSize = reports.fold<int>(0, (sum, r) => sum + r.fileSize);

  return {
    'totalReports': totalReports,
    'thisMonthReports': thisMonthReports,
    'totalSize': totalSize,
    'averageSize': totalReports > 0 ? totalSize / totalReports : 0,
  };
});
