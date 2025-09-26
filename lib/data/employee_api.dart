import 'package:employee_admin_dashboard/data/models/api_models.dart';
import 'package:employee_admin_dashboard/data/models/employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'employee_api.g.dart';

@RestApi()
abstract class EmployeeApi {
  factory EmployeeApi(Dio dio, {String baseUrl}) = _EmployeeApi;

  @GET('/employees')
  Future<EmployeeListResponse> getAllEmployees();

  @GET('/employees/{id}')
  Future<EmployeeResponse> getEmployeeById(@Path('id') String id);

  @POST('/employees')
  Future<EmployeeResponse> createEmployee(@Body() Employee employee);

  @PUT('/employees/{id}')
  Future<EmployeeResponse> updateEmployee(
    @Path('id') String id,
    @Body() Employee employee,
  );

  @DELETE('/employees/{id}')
  Future<DeleteResponse> deleteEmployee(@Path('id') String id);

  @GET('/employees/search')
  Future<EmployeeListResponse> searchEmployees(@Query('q') String query);
}

// Response classes for Employee API
@JsonSerializable()
class EmployeeResponse {
  final bool success;
  final Employee? data;
  final String? message;
  final String? error;

  EmployeeResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeResponseToJson(this);
}

@JsonSerializable()
class EmployeeListResponse {
  final bool success;
  final List<Employee>? data;
  final String? message;
  final String? error;

  EmployeeListResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeListResponseToJson(this);
}
