import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_record.freezed.dart';
part 'time_record.g.dart';

@freezed
class TimeRecord with _$TimeRecord {
  const factory TimeRecord({
    required String id,
    required String employeeId,
    required DateTime clockIn,
    DateTime? clockOut,
    Duration? totalDuration,
    @Default(TimeRecordStatus.active) TimeRecordStatus status,
    String? notes,
    String? location,
    @Default({}) Map<String, dynamic> metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TimeRecord;

  factory TimeRecord.fromJson(Map<String, dynamic> json) => _$TimeRecordFromJson(json);
}

@JsonEnum()
enum TimeRecordStatus {
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
  @JsonValue('break')
  break_,
  @JsonValue('overtime')
  overtime,
  @JsonValue('cancelled')
  cancelled,
}