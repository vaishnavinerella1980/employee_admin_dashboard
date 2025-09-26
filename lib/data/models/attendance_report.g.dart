// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceReportImpl _$$AttendanceReportImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceReportImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      records: (json['records'] as List<dynamic>)
          .map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
          ReportStatus.generating,
      filePath: json['filePath'] as String?,
      generatedAt: json['generatedAt'] == null
          ? null
          : DateTime.parse(json['generatedAt'] as String),
      statistics: json['statistics'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AttendanceReportImplToJson(
        _$AttendanceReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'records': instance.records,
      'status': _$ReportStatusEnumMap[instance.status]!,
      'filePath': instance.filePath,
      'generatedAt': instance.generatedAt?.toIso8601String(),
      'statistics': instance.statistics,
    };

const _$ReportStatusEnumMap = {
  ReportStatus.generating: 'generating',
  ReportStatus.completed: 'completed',
  ReportStatus.failed: 'failed',
};

_$AttendanceRecordImpl _$$AttendanceRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRecordImpl(
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      department: json['department'] as String,
      totalHours: (json['totalHours'] as num).toDouble(),
      daysWorked: (json['daysWorked'] as num).toInt(),
      daysAbsent: (json['daysAbsent'] as num).toInt(),
      overtimeHours: (json['overtimeHours'] as num).toDouble(),
      dailyRecords: (json['dailyRecords'] as List<dynamic>?)
              ?.map((e) => DailyAttendance.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AttendanceRecordImplToJson(
        _$AttendanceRecordImpl instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'department': instance.department,
      'totalHours': instance.totalHours,
      'daysWorked': instance.daysWorked,
      'daysAbsent': instance.daysAbsent,
      'overtimeHours': instance.overtimeHours,
      'dailyRecords': instance.dailyRecords,
    };

_$DailyAttendanceImpl _$$DailyAttendanceImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyAttendanceImpl(
      date: DateTime.parse(json['date'] as String),
      clockIn: json['clockIn'] == null
          ? null
          : DateTime.parse(json['clockIn'] as String),
      clockOut: json['clockOut'] == null
          ? null
          : DateTime.parse(json['clockOut'] as String),
      totalDuration: json['totalDuration'] == null
          ? null
          : Duration(microseconds: (json['totalDuration'] as num).toInt()),
      status: $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']) ??
          AttendanceStatus.absent,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$DailyAttendanceImplToJson(
        _$DailyAttendanceImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'clockIn': instance.clockIn?.toIso8601String(),
      'clockOut': instance.clockOut?.toIso8601String(),
      'totalDuration': instance.totalDuration?.inMicroseconds,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'notes': instance.notes,
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'present',
  AttendanceStatus.absent: 'absent',
  AttendanceStatus.late: 'late',
  AttendanceStatus.earlyLeave: 'early_leave',
  AttendanceStatus.holiday: 'holiday',
  AttendanceStatus.sickLeave: 'sick_leave',
};
