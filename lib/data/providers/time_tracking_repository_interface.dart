import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/domain/entities/time_record_entity.dart';

abstract class TimeTrackingRepository {
  Future<Either<Failure, TimeRecordEntity>> clockIn(String employeeId, {String? location});
  Future<Either<Failure, TimeRecordEntity>> clockOut(String employeeId, String recordId);
  Future<Either<Failure, List<TimeRecordEntity>>> getTimeRecords(String employeeId, {DateTime? startDate, DateTime? endDate});
  Future<Either<Failure, TimeRecordEntity>> updateTimeRecord(TimeRecordEntity record);
  Future<Either<Failure, void>> deleteTimeRecord(String recordId);
}