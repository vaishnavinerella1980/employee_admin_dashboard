import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class DeleteResponse {
  final bool success;
  final String? message;

  DeleteResponse({
    required this.success,
    this.message,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) => _$DeleteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteResponseToJson(this);
}

@JsonSerializable()
class ClockInRequest {
  @JsonKey(name: 'employee_id')
  final String employeeId;
  final String? location;
  final String? notes;

  ClockInRequest({
    required this.employeeId,
    this.location,
    this.notes,
  });

  factory ClockInRequest.fromJson(Map<String, dynamic> json) => _$ClockInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ClockInRequestToJson(this);
}

@JsonSerializable()
class ClockOutRequest {
  final String? notes;

  ClockOutRequest({this.notes});

  factory ClockOutRequest.fromJson(Map<String, dynamic> json) => _$ClockOutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ClockOutRequestToJson(this);
}