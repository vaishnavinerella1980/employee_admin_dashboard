import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:employee_admin_dashboard/core/utils/exceptions.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/data/employee_local_datasource.dart' show EmployeeLocalDataSource;
import 'package:employee_admin_dashboard/data/employee_remote_datasource.dart';
import 'package:employee_admin_dashboard/data/providers/employee_repository_interface.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/employee_entity.dart';
import '../models/employee.dart';

@LazySingleton(as: EmployeeRepository)
class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeLocalDataSource localDataSource;
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getAllEmployees() async {
    try {
      final remoteEmployees = await remoteDataSource.getAllEmployees();
      await localDataSource.cacheEmployees(remoteEmployees);
      final entities = remoteEmployees.map(_mapToEntity).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(ServerFailure("Network error: ${e.message ?? 'Unknown'}"));
    } on ServerException catch (e) {
      try {
        final localEmployees = await localDataSource.getCachedEmployees();
        final entities = localEmployees.map(_mapToEntity).toList();
        return Right(entities);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getEmployeeById(String id) async {
    try {
      final employee = await remoteDataSource.getEmployeeById(id);
      return Right(_mapToEntity(employee));
    } on DioException catch (e) {
      return Left(ServerFailure("Network error: ${e.message ?? 'Unknown'}"));
    } on ServerException catch (e) {
      try {
        final employee = await localDataSource.getEmployeeById(id);
        return Right(_mapToEntity(employee));
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> createEmployee(EmployeeEntity employee) async {
    try {
      final employeeModel = _mapFromEntity(employee);
      final createdEmployee = await remoteDataSource.createEmployee(employeeModel);
      await localDataSource.cacheEmployee(createdEmployee);
      return Right(_mapToEntity(createdEmployee));
    } on DioException catch (e) {
      return Left(ServerFailure("Network error: ${e.message ?? 'Unknown'}"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> updateEmployee(EmployeeEntity employee) async {
    try {
      final employeeModel = _mapFromEntity(employee);
      final updatedEmployee = await remoteDataSource.updateEmployee(employeeModel);
      await localDataSource.cacheEmployee(updatedEmployee);
      return Right(_mapToEntity(updatedEmployee));
    } on DioException catch (e) {
      return Left(ServerFailure("Network error: ${e.message ?? 'Unknown'}"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(String id) async {
    try {
      await remoteDataSource.deleteEmployee(id);
      await localDataSource.deleteEmployee(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure("Network error: ${e.message ?? 'Unknown'}"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failure, List<EmployeeEntity>>> searchEmployees(String query) async {
    try {
      final employees = await remoteDataSource.searchEmployees(query);
      final entities = employees.map(_mapToEntity).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(ServerFailure("Network error: ${e.message ?? 'Unknown'}"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  EmployeeEntity _mapToEntity(Employee model) {
    return EmployeeEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      department: model.department,
      position: model.position,
      phoneNumber: model.phoneNumber,
      avatarUrl: model.avatarUrl,
      isActive: model.isActive,
      isClockedIn: model.isClockedIn,
      lastClockIn: model.lastClockIn,
      lastClockOut: model.lastClockOut,
      hireDate: model.hireDate,
    );
  }

  Employee _mapFromEntity(EmployeeEntity entity) {
    return Employee(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      department: entity.department,
      position: entity.position,
      phoneNumber: entity.phoneNumber,
      avatarUrl: entity.avatarUrl,
      isActive: entity.isActive,
      isClockedIn: entity.isClockedIn,
      lastClockIn: entity.lastClockIn,
      lastClockOut: entity.lastClockOut,
      hireDate: entity.hireDate,
    );
  }
}
