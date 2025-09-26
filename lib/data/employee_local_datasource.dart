import 'package:employee_admin_dashboard/core/utils/exceptions.dart';
import 'package:employee_admin_dashboard/data/local/local_database.dart';
import 'package:employee_admin_dashboard/data/models/employee.dart';
import 'package:injectable/injectable.dart';

abstract class EmployeeLocalDataSource {
  Future<List<Employee>> getCachedEmployees();
  Future<Employee> getEmployeeById(String id);
  Future<void> cacheEmployee(Employee employee);
  Future<void> cacheEmployees(List<Employee> employees);
  Future<void> deleteEmployee(String id);
  Future<List<Employee>> searchEmployees(String query);
}

@LazySingleton(as: EmployeeLocalDataSource)
class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  final LocalDatabase _database;

  EmployeeLocalDataSourceImpl(this._database);

  @override
  Future<List<Employee>> getCachedEmployees() async {
    try {
      final employees = _database.getAllEmployees();
      if (employees.isEmpty) {
        throw CacheException('No cached employees found');
      }
      return employees;
    } catch (e) {
      throw CacheException('Failed to get cached employees: $e');
    }
  }

  @override
  Future<Employee> getEmployeeById(String id) async {
    try {
      final employee = _database.getEmployee(id);
      if (employee == null) {
        throw CacheException('Employee not found in cache');
      }
      return employee;
    } catch (e) {
      throw CacheException('Failed to get employee from cache: $e');
    }
  }

  @override
  Future<void> cacheEmployee(Employee employee) async {
    try {
      await _database.saveEmployee(employee);
    } catch (e) {
      throw CacheException('Failed to cache employee: $e');
    }
  }

  @override
  Future<void> cacheEmployees(List<Employee> employees) async {
    try {
      await _database.saveEmployees(employees);
    } catch (e) {
      throw CacheException('Failed to cache employees: $e');
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    try {
      await _database.deleteEmployee(id);
    } catch (e) {
      throw CacheException('Failed to delete employee from cache: $e');
    }
  }

  @override
  Future<List<Employee>> searchEmployees(String query) async {
    try {
      final employees = _database.searchEmployees(query);
      return employees;
    } catch (e) {
      throw CacheException('Failed to search employees in cache: $e');
    }
  }
}
