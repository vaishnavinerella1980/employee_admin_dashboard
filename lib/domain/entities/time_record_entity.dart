class TimeRecordEntity {
  final String id;
  final String employeeId;
  final DateTime clockIn;
  final DateTime? clockOut;
  final Duration? totalDuration;
  final String status;
  final String? notes;
  final String? location;

  const TimeRecordEntity({
    required this.id,
    required this.employeeId,
    required this.clockIn,
    this.clockOut,
    this.totalDuration,
    required this.status,
    this.notes,
    this.location,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeRecordEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
