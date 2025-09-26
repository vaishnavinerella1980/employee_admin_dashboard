// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceReport _$AttendanceReportFromJson(Map<String, dynamic> json) {
  return _AttendanceReport.fromJson(json);
}

/// @nodoc
mixin _$AttendanceReport {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<AttendanceRecord> get records => throw _privateConstructorUsedError;
  ReportStatus get status => throw _privateConstructorUsedError;
  String? get filePath => throw _privateConstructorUsedError;
  DateTime? get generatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get statistics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceReportCopyWith<AttendanceReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceReportCopyWith<$Res> {
  factory $AttendanceReportCopyWith(
          AttendanceReport value, $Res Function(AttendanceReport) then) =
      _$AttendanceReportCopyWithImpl<$Res, AttendanceReport>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime startDate,
      DateTime endDate,
      List<AttendanceRecord> records,
      ReportStatus status,
      String? filePath,
      DateTime? generatedAt,
      Map<String, dynamic> statistics});
}

/// @nodoc
class _$AttendanceReportCopyWithImpl<$Res, $Val extends AttendanceReport>
    implements $AttendanceReportCopyWith<$Res> {
  _$AttendanceReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? records = null,
    Object? status = null,
    Object? filePath = freezed,
    Object? generatedAt = freezed,
    Object? statistics = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReportStatus,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedAt: freezed == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceReportImplCopyWith<$Res>
    implements $AttendanceReportCopyWith<$Res> {
  factory _$$AttendanceReportImplCopyWith(_$AttendanceReportImpl value,
          $Res Function(_$AttendanceReportImpl) then) =
      __$$AttendanceReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime startDate,
      DateTime endDate,
      List<AttendanceRecord> records,
      ReportStatus status,
      String? filePath,
      DateTime? generatedAt,
      Map<String, dynamic> statistics});
}

/// @nodoc
class __$$AttendanceReportImplCopyWithImpl<$Res>
    extends _$AttendanceReportCopyWithImpl<$Res, _$AttendanceReportImpl>
    implements _$$AttendanceReportImplCopyWith<$Res> {
  __$$AttendanceReportImplCopyWithImpl(_$AttendanceReportImpl _value,
      $Res Function(_$AttendanceReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? records = null,
    Object? status = null,
    Object? filePath = freezed,
    Object? generatedAt = freezed,
    Object? statistics = null,
  }) {
    return _then(_$AttendanceReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceRecord>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReportStatus,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedAt: freezed == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      statistics: null == statistics
          ? _value._statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceReportImpl implements _AttendanceReport {
  const _$AttendanceReportImpl(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required final List<AttendanceRecord> records,
      this.status = ReportStatus.generating,
      this.filePath,
      this.generatedAt,
      final Map<String, dynamic> statistics = const {}})
      : _records = records,
        _statistics = statistics;

  factory _$AttendanceReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceReportImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<AttendanceRecord> _records;
  @override
  List<AttendanceRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  @JsonKey()
  final ReportStatus status;
  @override
  final String? filePath;
  @override
  final DateTime? generatedAt;
  final Map<String, dynamic> _statistics;
  @override
  @JsonKey()
  Map<String, dynamic> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  @override
  String toString() {
    return 'AttendanceReport(id: $id, title: $title, startDate: $startDate, endDate: $endDate, records: $records, status: $status, filePath: $filePath, generatedAt: $generatedAt, statistics: $statistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality()
                .equals(other._statistics, _statistics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_records),
      status,
      filePath,
      generatedAt,
      const DeepCollectionEquality().hash(_statistics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceReportImplCopyWith<_$AttendanceReportImpl> get copyWith =>
      __$$AttendanceReportImplCopyWithImpl<_$AttendanceReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceReportImplToJson(
      this,
    );
  }
}

abstract class _AttendanceReport implements AttendanceReport {
  const factory _AttendanceReport(
      {required final String id,
      required final String title,
      required final DateTime startDate,
      required final DateTime endDate,
      required final List<AttendanceRecord> records,
      final ReportStatus status,
      final String? filePath,
      final DateTime? generatedAt,
      final Map<String, dynamic> statistics}) = _$AttendanceReportImpl;

  factory _AttendanceReport.fromJson(Map<String, dynamic> json) =
      _$AttendanceReportImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<AttendanceRecord> get records;
  @override
  ReportStatus get status;
  @override
  String? get filePath;
  @override
  DateTime? get generatedAt;
  @override
  Map<String, dynamic> get statistics;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceReportImplCopyWith<_$AttendanceReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) {
  return _AttendanceRecord.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRecord {
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  double get totalHours => throw _privateConstructorUsedError;
  int get daysWorked => throw _privateConstructorUsedError;
  int get daysAbsent => throw _privateConstructorUsedError;
  double get overtimeHours => throw _privateConstructorUsedError;
  List<DailyAttendance> get dailyRecords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceRecordCopyWith<AttendanceRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRecordCopyWith<$Res> {
  factory $AttendanceRecordCopyWith(
          AttendanceRecord value, $Res Function(AttendanceRecord) then) =
      _$AttendanceRecordCopyWithImpl<$Res, AttendanceRecord>;
  @useResult
  $Res call(
      {String employeeId,
      String employeeName,
      String department,
      double totalHours,
      int daysWorked,
      int daysAbsent,
      double overtimeHours,
      List<DailyAttendance> dailyRecords});
}

/// @nodoc
class _$AttendanceRecordCopyWithImpl<$Res, $Val extends AttendanceRecord>
    implements $AttendanceRecordCopyWith<$Res> {
  _$AttendanceRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeName = null,
    Object? department = null,
    Object? totalHours = null,
    Object? daysWorked = null,
    Object? daysAbsent = null,
    Object? overtimeHours = null,
    Object? dailyRecords = null,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      totalHours: null == totalHours
          ? _value.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      daysWorked: null == daysWorked
          ? _value.daysWorked
          : daysWorked // ignore: cast_nullable_to_non_nullable
              as int,
      daysAbsent: null == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int,
      overtimeHours: null == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double,
      dailyRecords: null == dailyRecords
          ? _value.dailyRecords
          : dailyRecords // ignore: cast_nullable_to_non_nullable
              as List<DailyAttendance>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceRecordImplCopyWith<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  factory _$$AttendanceRecordImplCopyWith(_$AttendanceRecordImpl value,
          $Res Function(_$AttendanceRecordImpl) then) =
      __$$AttendanceRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String employeeId,
      String employeeName,
      String department,
      double totalHours,
      int daysWorked,
      int daysAbsent,
      double overtimeHours,
      List<DailyAttendance> dailyRecords});
}

/// @nodoc
class __$$AttendanceRecordImplCopyWithImpl<$Res>
    extends _$AttendanceRecordCopyWithImpl<$Res, _$AttendanceRecordImpl>
    implements _$$AttendanceRecordImplCopyWith<$Res> {
  __$$AttendanceRecordImplCopyWithImpl(_$AttendanceRecordImpl _value,
      $Res Function(_$AttendanceRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeName = null,
    Object? department = null,
    Object? totalHours = null,
    Object? daysWorked = null,
    Object? daysAbsent = null,
    Object? overtimeHours = null,
    Object? dailyRecords = null,
  }) {
    return _then(_$AttendanceRecordImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      totalHours: null == totalHours
          ? _value.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      daysWorked: null == daysWorked
          ? _value.daysWorked
          : daysWorked // ignore: cast_nullable_to_non_nullable
              as int,
      daysAbsent: null == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int,
      overtimeHours: null == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double,
      dailyRecords: null == dailyRecords
          ? _value._dailyRecords
          : dailyRecords // ignore: cast_nullable_to_non_nullable
              as List<DailyAttendance>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRecordImpl implements _AttendanceRecord {
  const _$AttendanceRecordImpl(
      {required this.employeeId,
      required this.employeeName,
      required this.department,
      required this.totalHours,
      required this.daysWorked,
      required this.daysAbsent,
      required this.overtimeHours,
      final List<DailyAttendance> dailyRecords = const []})
      : _dailyRecords = dailyRecords;

  factory _$AttendanceRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRecordImplFromJson(json);

  @override
  final String employeeId;
  @override
  final String employeeName;
  @override
  final String department;
  @override
  final double totalHours;
  @override
  final int daysWorked;
  @override
  final int daysAbsent;
  @override
  final double overtimeHours;
  final List<DailyAttendance> _dailyRecords;
  @override
  @JsonKey()
  List<DailyAttendance> get dailyRecords {
    if (_dailyRecords is EqualUnmodifiableListView) return _dailyRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyRecords);
  }

  @override
  String toString() {
    return 'AttendanceRecord(employeeId: $employeeId, employeeName: $employeeName, department: $department, totalHours: $totalHours, daysWorked: $daysWorked, daysAbsent: $daysAbsent, overtimeHours: $overtimeHours, dailyRecords: $dailyRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRecordImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.daysWorked, daysWorked) ||
                other.daysWorked == daysWorked) &&
            (identical(other.daysAbsent, daysAbsent) ||
                other.daysAbsent == daysAbsent) &&
            (identical(other.overtimeHours, overtimeHours) ||
                other.overtimeHours == overtimeHours) &&
            const DeepCollectionEquality()
                .equals(other._dailyRecords, _dailyRecords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employeeId,
      employeeName,
      department,
      totalHours,
      daysWorked,
      daysAbsent,
      overtimeHours,
      const DeepCollectionEquality().hash(_dailyRecords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRecordImplCopyWith<_$AttendanceRecordImpl> get copyWith =>
      __$$AttendanceRecordImplCopyWithImpl<_$AttendanceRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRecordImplToJson(
      this,
    );
  }
}

abstract class _AttendanceRecord implements AttendanceRecord {
  const factory _AttendanceRecord(
      {required final String employeeId,
      required final String employeeName,
      required final String department,
      required final double totalHours,
      required final int daysWorked,
      required final int daysAbsent,
      required final double overtimeHours,
      final List<DailyAttendance> dailyRecords}) = _$AttendanceRecordImpl;

  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) =
      _$AttendanceRecordImpl.fromJson;

  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  String get department;
  @override
  double get totalHours;
  @override
  int get daysWorked;
  @override
  int get daysAbsent;
  @override
  double get overtimeHours;
  @override
  List<DailyAttendance> get dailyRecords;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceRecordImplCopyWith<_$AttendanceRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyAttendance _$DailyAttendanceFromJson(Map<String, dynamic> json) {
  return _DailyAttendance.fromJson(json);
}

/// @nodoc
mixin _$DailyAttendance {
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get clockIn => throw _privateConstructorUsedError;
  DateTime? get clockOut => throw _privateConstructorUsedError;
  Duration? get totalDuration => throw _privateConstructorUsedError;
  AttendanceStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyAttendanceCopyWith<DailyAttendance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyAttendanceCopyWith<$Res> {
  factory $DailyAttendanceCopyWith(
          DailyAttendance value, $Res Function(DailyAttendance) then) =
      _$DailyAttendanceCopyWithImpl<$Res, DailyAttendance>;
  @useResult
  $Res call(
      {DateTime date,
      DateTime? clockIn,
      DateTime? clockOut,
      Duration? totalDuration,
      AttendanceStatus status,
      String? notes});
}

/// @nodoc
class _$DailyAttendanceCopyWithImpl<$Res, $Val extends DailyAttendance>
    implements $DailyAttendanceCopyWith<$Res> {
  _$DailyAttendanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? clockIn = freezed,
    Object? clockOut = freezed,
    Object? totalDuration = freezed,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clockIn: freezed == clockIn
          ? _value.clockIn
          : clockIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clockOut: freezed == clockOut
          ? _value.clockOut
          : clockOut // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalDuration: freezed == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AttendanceStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyAttendanceImplCopyWith<$Res>
    implements $DailyAttendanceCopyWith<$Res> {
  factory _$$DailyAttendanceImplCopyWith(_$DailyAttendanceImpl value,
          $Res Function(_$DailyAttendanceImpl) then) =
      __$$DailyAttendanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      DateTime? clockIn,
      DateTime? clockOut,
      Duration? totalDuration,
      AttendanceStatus status,
      String? notes});
}

/// @nodoc
class __$$DailyAttendanceImplCopyWithImpl<$Res>
    extends _$DailyAttendanceCopyWithImpl<$Res, _$DailyAttendanceImpl>
    implements _$$DailyAttendanceImplCopyWith<$Res> {
  __$$DailyAttendanceImplCopyWithImpl(
      _$DailyAttendanceImpl _value, $Res Function(_$DailyAttendanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? clockIn = freezed,
    Object? clockOut = freezed,
    Object? totalDuration = freezed,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_$DailyAttendanceImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clockIn: freezed == clockIn
          ? _value.clockIn
          : clockIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clockOut: freezed == clockOut
          ? _value.clockOut
          : clockOut // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalDuration: freezed == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AttendanceStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyAttendanceImpl implements _DailyAttendance {
  const _$DailyAttendanceImpl(
      {required this.date,
      this.clockIn,
      this.clockOut,
      this.totalDuration,
      this.status = AttendanceStatus.absent,
      this.notes});

  factory _$DailyAttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyAttendanceImplFromJson(json);

  @override
  final DateTime date;
  @override
  final DateTime? clockIn;
  @override
  final DateTime? clockOut;
  @override
  final Duration? totalDuration;
  @override
  @JsonKey()
  final AttendanceStatus status;
  @override
  final String? notes;

  @override
  String toString() {
    return 'DailyAttendance(date: $date, clockIn: $clockIn, clockOut: $clockOut, totalDuration: $totalDuration, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyAttendanceImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.clockIn, clockIn) || other.clockIn == clockIn) &&
            (identical(other.clockOut, clockOut) ||
                other.clockOut == clockOut) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, clockIn, clockOut, totalDuration, status, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyAttendanceImplCopyWith<_$DailyAttendanceImpl> get copyWith =>
      __$$DailyAttendanceImplCopyWithImpl<_$DailyAttendanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyAttendanceImplToJson(
      this,
    );
  }
}

abstract class _DailyAttendance implements DailyAttendance {
  const factory _DailyAttendance(
      {required final DateTime date,
      final DateTime? clockIn,
      final DateTime? clockOut,
      final Duration? totalDuration,
      final AttendanceStatus status,
      final String? notes}) = _$DailyAttendanceImpl;

  factory _DailyAttendance.fromJson(Map<String, dynamic> json) =
      _$DailyAttendanceImpl.fromJson;

  @override
  DateTime get date;
  @override
  DateTime? get clockIn;
  @override
  DateTime? get clockOut;
  @override
  Duration? get totalDuration;
  @override
  AttendanceStatus get status;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$DailyAttendanceImplCopyWith<_$DailyAttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
