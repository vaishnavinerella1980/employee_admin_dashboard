// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteResponse _$DeleteResponseFromJson(Map<String, dynamic> json) =>
    DeleteResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeleteResponseToJson(DeleteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

ClockInRequest _$ClockInRequestFromJson(Map<String, dynamic> json) =>
    ClockInRequest(
      employeeId: json['employee_id'] as String,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ClockInRequestToJson(ClockInRequest instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'location': instance.location,
      'notes': instance.notes,
    };

ClockOutRequest _$ClockOutRequestFromJson(Map<String, dynamic> json) =>
    ClockOutRequest(
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ClockOutRequestToJson(ClockOutRequest instance) =>
    <String, dynamic>{
      'notes': instance.notes,
    };
