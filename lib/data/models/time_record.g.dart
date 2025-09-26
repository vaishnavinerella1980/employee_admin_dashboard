// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeRecordImpl _$$TimeRecordImplFromJson(Map<String, dynamic> json) =>
    _$TimeRecordImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      clockIn: DateTime.parse(json['clockIn'] as String),
      clockOut: json['clockOut'] == null
          ? null
          : DateTime.parse(json['clockOut'] as String),
      totalDuration: json['totalDuration'] == null
          ? null
          : Duration(microseconds: (json['totalDuration'] as num).toInt()),
      status: $enumDecodeNullable(_$TimeRecordStatusEnumMap, json['status']) ??
          TimeRecordStatus.active,
      notes: json['notes'] as String?,
      location: json['location'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TimeRecordImplToJson(_$TimeRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'clockIn': instance.clockIn.toIso8601String(),
      'clockOut': instance.clockOut?.toIso8601String(),
      'totalDuration': instance.totalDuration?.inMicroseconds,
      'status': _$TimeRecordStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'location': instance.location,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$TimeRecordStatusEnumMap = {
  TimeRecordStatus.active: 'active',
  TimeRecordStatus.completed: 'completed',
  TimeRecordStatus.break_: 'break',
  TimeRecordStatus.overtime: 'overtime',
  TimeRecordStatus.cancelled: 'cancelled',
};
