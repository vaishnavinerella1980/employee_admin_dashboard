// lib/data/employee_remote_datasource.dart
import 'package:employee_admin_dashboard/core/utils/exceptions.dart';
import 'package:employee_admin_dashboard/data/models/employee.dart';
import 'package:injectable/injectable.dart';
import 'employee_api.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<Employee>> getAllEmployees();
  Future<Employee> getEmployeeById(String id);
  Future<Employee> createEmployee(Employee employee);
  Future<Employee> updateEmployee(Employee employee);
  Future<void> deleteEmployee(String id);
  Future<List<Employee>> searchEmployees(String query);
}

@LazySingleton(as: EmployeeRemoteDataSource)
class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final EmployeeApi _api;

  EmployeeRemoteDataSourceImpl(this._api);

  @override
  Future<List<Employee>> getAllEmployees() async {
    try {
      final response = await _api.getAllEmployees();
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to fetch employees');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<Employee> getEmployeeById(String id) async {
    try {
      final response = await _api.getEmployeeById(id);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Employee not found');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<Employee> createEmployee(Employee employee) async {
    try {
      final response = await _api.createEmployee(employee);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to create employee');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<Employee> updateEmployee(Employee employee) async {
    try {
      final response = await _api.updateEmployee(employee.id, employee);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to update employee');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    try {
      final response = await _api.deleteEmployee(id);
      if (!response.success) {
        throw ServerException(response.message ?? 'Failed to delete employee');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<List<Employee>> searchEmployees(String query) async {
    try {
      final response = await _api.searchEmployees(query);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Search failed');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }
}
