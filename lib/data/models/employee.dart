import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  const factory Employee({
    required String id,
    required String name,
    required String email,
    required String department,
    required String position,
    String? phoneNumber,
    String? avatarUrl,
    @Default(false) bool isActive,
    @Default(false) bool isClockedIn,
    DateTime? lastClockIn,
    DateTime? lastClockOut,
    DateTime? hireDate,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
}