import 'package:employee_admin_dashboard/core/utils/exceptions.dart';
import 'package:employee_admin_dashboard/data/models/api_models.dart';
import 'package:employee_admin_dashboard/data/models/time_record.dart';
import 'package:injectable/injectable.dart';
import 'time_tracking_api.dart';

abstract class TimeTrackingRemoteDataSource {
  Future<TimeRecord> clockIn(String employeeId,
      {String? location, String? notes});
  Future<TimeRecord> clockOut(String recordId, {String? notes});
  Future<List<TimeRecord>> getTimeRecords(String employeeId,
      {DateTime? startDate, DateTime? endDate});
  Future<TimeRecord> getTimeRecord(String id);
  Future<TimeRecord> updateTimeRecord(TimeRecord record);
  Future<void> deleteTimeRecord(String id);
  Future<List<TimeRecord>> getActiveTimeRecords();
}

@LazySingleton(as: TimeTrackingRemoteDataSource)
class TimeTrackingRemoteDataSourceImpl implements TimeTrackingRemoteDataSource {
  final TimeTrackingApi _api;

  TimeTrackingRemoteDataSourceImpl(this._api);

  @override
  Future<TimeRecord> clockIn(String employeeId,
      {String? location, String? notes}) async {
    try {
      final request = ClockInRequest(
        employeeId: employeeId,
        location: location,
        notes: notes,
      );
      final response = await _api.clockIn(request);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to clock in');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<TimeRecord> clockOut(String recordId, {String? notes}) async {
    try {
      final request = ClockOutRequest(notes: notes);
      final response = await _api.clockOut(recordId, request);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to clock out');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<List<TimeRecord>> getTimeRecords(String employeeId,
      {DateTime? startDate, DateTime? endDate}) async {
    try {
      final response = await _api.getTimeRecords(
        employeeId,
        startDate?.toIso8601String(),
        endDate?.toIso8601String(),
      );
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to fetch time records');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<TimeRecord> getTimeRecord(String id) async {
    try {
      final response = await _api.getTimeRecord(id);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Time record not found');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<TimeRecord> updateTimeRecord(TimeRecord record) async {
    try {
      final response = await _api.updateTimeRecord(record.id, record);
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to update time record');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<void> deleteTimeRecord(String id) async {
    try {
      final response = await _api.deleteTimeRecord(id);
      if (!response.success) {
        throw ServerException(
            response.message ?? 'Failed to delete time record');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<List<TimeRecord>> getActiveTimeRecords() async {
    try {
      final response = await _api.getActiveTimeRecords();
      if (response.success && response.data != null) {
        return response.data!;
      }
      throw ServerException(response.error ?? 'Failed to fetch active records');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: $e');
    }
  }
}
