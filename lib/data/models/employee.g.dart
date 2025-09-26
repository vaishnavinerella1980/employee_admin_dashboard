// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeImpl _$$EmployeeImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      isClockedIn: json['isClockedIn'] as bool? ?? false,
      lastClockIn: json['lastClockIn'] == null
          ? null
          : DateTime.parse(json['lastClockIn'] as String),
      lastClockOut: json['lastClockOut'] == null
          ? null
          : DateTime.parse(json['lastClockOut'] as String),
      hireDate: json['hireDate'] == null
          ? null
          : DateTime.parse(json['hireDate'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$EmployeeImplToJson(_$EmployeeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'department': instance.department,
      'position': instance.position,
      'phoneNumber': instance.phoneNumber,
      'avatarUrl': instance.avatarUrl,
      'isActive': instance.isActive,
      'isClockedIn': instance.isClockedIn,
      'lastClockIn': instance.lastClockIn?.toIso8601String(),
      'lastClockOut': instance.lastClockOut?.toIso8601String(),
      'hireDate': instance.hireDate?.toIso8601String(),
      'metadata': instance.metadata,
    };
