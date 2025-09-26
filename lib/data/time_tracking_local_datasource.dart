import 'package:employee_admin_dashboard/core/utils/exceptions.dart';
import 'package:employee_admin_dashboard/data/local/local_database.dart';
import 'package:employee_admin_dashboard/data/models/time_record.dart';
import 'package:injectable/injectable.dart';

abstract class TimeTrackingLocalDataSource {
  Future<List<TimeRecord>> getCachedTimeRecords();
  Future<List<TimeRecord>> getTimeRecordsByEmployee(String employeeId);
  Future<List<TimeRecord>> getTimeRecordsByDateRange(DateTime start, DateTime end);
  Future<TimeRecord> getTimeRecordById(String id);
  Future<void> cacheTimeRecord(TimeRecord record);
  Future<void> cacheTimeRecords(List<TimeRecord> records);
  Future<void> deleteTimeRecord(String id);
}

@LazySingleton(as: TimeTrackingLocalDataSource)
class TimeTrackingLocalDataSourceImpl implements TimeTrackingLocalDataSource {
  final LocalDatabase _database;

  TimeTrackingLocalDataSourceImpl(this._database);

  @override
  Future<List<TimeRecord>> getCachedTimeRecords() async {
    try {
      final records = _database.getAllTimeRecords();
      return records;
    } catch (e) {
      throw CacheException('Failed to get cached time records: $e');
    }
  }

  @override
  Future<List<TimeRecord>> getTimeRecordsByEmployee(String employeeId) async {
    try {
      final records = _database.getTimeRecordsByEmployee(employeeId);
      return records;
    } catch (e) {
      throw CacheException('Failed to get time records for employee: $e');
    }
  }

  @override
  Future<List<TimeRecord>> getTimeRecordsByDateRange(DateTime start, DateTime end) async {
    try {
      final records = _database.getTimeRecordsByDateRange(start, end);
      return records;
    } catch (e) {
      throw CacheException('Failed to get time records by date range: $e');
    }
  }

  @override
  Future<TimeRecord> getTimeRecordById(String id) async {
    try {
      final record = _database.getTimeRecord(id);
      if (record == null) {
        throw CacheException('Time record not found in cache');
      }
      return record;
    } catch (e) {
      throw CacheException('Failed to get time record from cache: $e');
    }
  }

  @override
  Future<void> cacheTimeRecord(TimeRecord record) async {
    try {
      await _database.saveTimeRecord(record);
    } catch (e) {
      throw CacheException('Failed to cache time record: $e');
    }
  }

  @override
  Future<void> cacheTimeRecords(List<TimeRecord> records) async {
    try {
      await _database.saveTimeRecords(records);
    } catch (e) {
      throw CacheException('Failed to cache time records: $e');
    }
  }

  @override
  Future<void> deleteTimeRecord(String id) async {
    try {
      await _database.deleteTimeRecord(id);
    } catch (e) {
      throw CacheException('Failed to delete time record from cache: $e');
    }
  }
}