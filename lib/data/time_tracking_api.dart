import 'package:employee_admin_dashboard/data/models/api_models.dart';
import 'package:employee_admin_dashboard/data/models/time_record.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'time_tracking_api.g.dart';

@RestApi()
abstract class TimeTrackingApi {
  factory TimeTrackingApi(Dio dio, {String baseUrl}) = _TimeTrackingApi;

  @POST('/time-records/clock-in')
  Future<TimeRecordResponse> clockIn(@Body() ClockInRequest request);

  @PUT('/time-records/{id}/clock-out')
  Future<TimeRecordResponse> clockOut(
    @Path('id') String recordId,
    @Body() ClockOutRequest request,
  );

  @GET('/time-records/employee/{employeeId}')
  Future<TimeRecordListResponse> getTimeRecords(
    @Path('employeeId') String employeeId,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
  );

  @GET('/time-records/{id}')
  Future<TimeRecordResponse> getTimeRecord(@Path('id') String id);

  @PUT('/time-records/{id}')
  Future<TimeRecordResponse> updateTimeRecord(
    @Path('id') String id,
    @Body() TimeRecord record,
  );

  @DELETE('/time-records/{id}')
  Future<DeleteResponse> deleteTimeRecord(@Path('id') String id);

  @GET('/time-records/active')
  Future<TimeRecordListResponse> getActiveTimeRecords();
}

// Response classes for TimeRecord API
@JsonSerializable()
class TimeRecordResponse {
  final bool success;
  final TimeRecord? data;
  final String? message;
  final String? error;

  TimeRecordResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory TimeRecordResponse.fromJson(Map<String, dynamic> json) => _$TimeRecordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRecordResponseToJson(this);
}

@JsonSerializable()
class TimeRecordListResponse {
  final bool success;
  final List<TimeRecord>? data;
  final String? message;
  final String? error;

  TimeRecordListResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory TimeRecordListResponse.fromJson(Map<String, dynamic> json) => _$TimeRecordListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRecordListResponseToJson(this);
}