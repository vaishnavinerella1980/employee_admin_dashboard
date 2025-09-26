import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/domain/entities/employee_entity.dart';
abstract class EmployeeRepository {
  Future<Either<Failure, List<EmployeeEntity>>> getAllEmployees();
  Future<Either<Failure, EmployeeEntity>> getEmployeeById(String id);
  Future<Either<Failure, EmployeeEntity>> createEmployee(EmployeeEntity employee);
  Future<Either<Failure, EmployeeEntity>> updateEmployee(EmployeeEntity employee);
  Future<Either<Failure, void>> deleteEmployee(String id);
  Future<Either<Failure, List<EmployeeEntity>>> searchEmployees(String query);
}