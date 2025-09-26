import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_report.freezed.dart';
part 'attendance_report.g.dart';

@freezed
class AttendanceReport with _$AttendanceReport {
  const factory AttendanceReport({
    required String id,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required List<AttendanceRecord> records,
    @Default(ReportStatus.generating) ReportStatus status,
    String? filePath,
    DateTime? generatedAt,
    @Default({}) Map<String, dynamic> statistics,
  }) = _AttendanceReport;

  factory AttendanceReport.fromJson(Map<String, dynamic> json) => _$AttendanceReportFromJson(json);
}

@freezed
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required String employeeId,
    required String employeeName,
    required String department,
    required double totalHours,
    required int daysWorked,
    required int daysAbsent,
    required double overtimeHours,
    @Default([]) List<DailyAttendance> dailyRecords,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) => _$AttendanceRecordFromJson(json);
}

@freezed
class DailyAttendance with _$DailyAttendance {
  const factory DailyAttendance({
    required DateTime date,
    DateTime? clockIn,
    DateTime? clockOut,
    Duration? totalDuration,
    @Default(AttendanceStatus.absent) AttendanceStatus status,
    String? notes,
  }) = _DailyAttendance;

  factory DailyAttendance.fromJson(Map<String, dynamic> json) => _$DailyAttendanceFromJson(json);
}

enum ReportStatus {
  @JsonValue('generating')
  generating,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

enum AttendanceStatus {
  @JsonValue('present')
  present,
  @JsonValue('absent')
  absent,
  @JsonValue('late')
  late,
  @JsonValue('early_leave')
  earlyLeave,
  @JsonValue('holiday')
  holiday,
  @JsonValue('sick_leave')
  sickLeave,
}