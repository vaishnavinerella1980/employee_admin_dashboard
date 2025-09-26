
import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/exceptions.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository_interface.dart';
import 'package:employee_admin_dashboard/data/time_tracking_local_datasource.dart';
import 'package:employee_admin_dashboard/data/time_tracking_remote_datasource.dart';
import 'package:injectable/injectable.dart';
  // This was missing!
import '../../domain/entities/time_record_entity.dart';
import '../models/time_record.dart';

@LazySingleton(as: TimeTrackingRepository)
class TimeTrackingRepositoryImpl implements TimeTrackingRepository {
  final TimeTrackingLocalDataSource localDataSource;
  final TimeTrackingRemoteDataSource remoteDataSource;

  TimeTrackingRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TimeRecordEntity>> clockIn(String employeeId, {String? location}) async {
    try {
      final record = await remoteDataSource.clockIn(employeeId, location: location);
      await localDataSource.cacheTimeRecord(record);
      return Right(_mapToEntity(record));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TimeRecordEntity>> clockOut(String employeeId, String recordId) async {
    try {
      final record = await remoteDataSource.clockOut(recordId);
      await localDataSource.cacheTimeRecord(record);
      return Right(_mapToEntity(record));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TimeRecordEntity>>> getTimeRecords(String employeeId, {DateTime? startDate, DateTime? endDate}) async {
    try {
      final records = await remoteDataSource.getTimeRecords(employeeId, startDate: startDate, endDate: endDate);
      await localDataSource.cacheTimeRecords(records);
      return Right(records.map(_mapToEntity).toList());
    } on ServerException catch (e) {
      try {
        final cachedRecords = await localDataSource.getTimeRecordsByEmployee(employeeId);
        return Right(cachedRecords.map(_mapToEntity).toList());
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TimeRecordEntity>> updateTimeRecord(TimeRecordEntity record) async {
    try {
      final updatedRecord = await remoteDataSource.updateTimeRecord(_mapFromEntity(record));
      await localDataSource.cacheTimeRecord(updatedRecord);
      return Right(_mapToEntity(updatedRecord));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTimeRecord(String recordId) async {
    try {
      await remoteDataSource.deleteTimeRecord(recordId);
      await localDataSource.deleteTimeRecord(recordId);
      return Right(null);  // FIXED: Removed 'const' keyword
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  TimeRecordEntity _mapToEntity(TimeRecord model) {
    return TimeRecordEntity(
      id: model.id,
      employeeId: model.employeeId,
      clockIn: model.clockIn,
      clockOut: model.clockOut,
      totalDuration: model.totalDuration,
      status: model.status.toString(),
      notes: model.notes,
      location: model.location,
    );
  }

  TimeRecord _mapFromEntity(TimeRecordEntity entity) {
    return TimeRecord(
      id: entity.id,
      employeeId: entity.employeeId,
      clockIn: entity.clockIn,
      clockOut: entity.clockOut,
      totalDuration: entity.totalDuration,
      status: TimeRecordStatus.values.firstWhere(
        (status) => status.toString() == entity.status,
        orElse: () => TimeRecordStatus.active,
      ),
      notes: entity.notes,
      location: entity.location,
    );
  }
}

