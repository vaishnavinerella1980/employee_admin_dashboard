import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'reports_api.g.dart';
part 'reports_api.freezed.dart';

@RestApi()
abstract class ReportsApi {
  factory ReportsApi(Dio dio, {String baseUrl}) = _ReportsApi;

  @POST('/reports/generate')
  Future<ReportResponse> generateReport(@Body() GenerateReportRequest request);

  @GET('/reports')
  Future<ReportsListResponse> getReports({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('type') String? type,
  });

  @GET('/reports/{id}')
  Future<ReportResponse> getReport(@Path('id') String id);

  @GET('/reports/{id}/download')
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> downloadReport(@Path('id') String id);

  @DELETE('/reports/{id}')
  Future<DeleteResponse> deleteReport(@Path('id') String id);

  @GET('/reports/types')
  Future<ReportTypesResponse> getReportTypes();
}

// Request models
@freezed
class GenerateReportRequest with _$GenerateReportRequest {
  const factory GenerateReportRequest({
    required String reportType,
    required String period,
    DateTime? fromDate,
    DateTime? toDate,
    String? department,
    String? employeeId,
    @Default({}) Map<String, dynamic> parameters,
  }) = _GenerateReportRequest;

  factory GenerateReportRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateReportRequestFromJson(json);
}

// Response models
@freezed
class ReportResponse with _$ReportResponse {
  const factory ReportResponse({
    required bool success,
    ReportData? data,
    String? message,
    String? error,
  }) = _ReportResponse;

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);
}

@freezed
class ReportsListResponse with _$ReportsListResponse {
  const factory ReportsListResponse({
    required bool success,
    required List<ReportData> data,
    int? total,
    int? page,
    int? limit,
    String? message,
    String? error,
  }) = _ReportsListResponse;

  factory ReportsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportsListResponseFromJson(json);
}

@freezed
class ReportTypesResponse with _$ReportTypesResponse {
  const factory ReportTypesResponse({
    required bool success,
    required List<ReportTypeData> data,
    String? message,
    String? error,
  }) = _ReportTypesResponse;

  factory ReportTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportTypesResponseFromJson(json);
}

@freezed
class DeleteResponse with _$DeleteResponse {
  const factory DeleteResponse({
    required bool success,
    String? message,
    String? error,
  }) = _DeleteResponse;

  factory DeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteResponseFromJson(json);
}

// Data models
@freezed
class ReportData with _$ReportData {
  const factory ReportData({
    required String id,
    required String name,
    required String type,
    required DateTime generatedAt,
    required String generatedBy,
    required Map<String, dynamic> parameters,
    required String fileUrl,
    required int fileSize,
    String? description,
    DateTime? expiresAt,
    String? status,
  }) = _ReportData;

  factory ReportData.fromJson(Map<String, dynamic> json) =>
      _$ReportDataFromJson(json);
}

@freezed
class ReportTypeData with _$ReportTypeData {
  const factory ReportTypeData({
    required String id,
    required String name,
    required String description,
    required List<String> requiredParameters,
    required List<String> optionalParameters,
  }) = _ReportTypeData;

  factory ReportTypeData.fromJson(Map<String, dynamic> json) =>
      _$ReportTypeDataFromJson(json);
}
