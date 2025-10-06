// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GenerateReportRequest _$GenerateReportRequestFromJson(
    Map<String, dynamic> json) {
  return _GenerateReportRequest.fromJson(json);
}

/// @nodoc
mixin _$GenerateReportRequest {
  String get reportType => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  DateTime? get fromDate => throw _privateConstructorUsedError;
  DateTime? get toDate => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get employeeId => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateReportRequestCopyWith<GenerateReportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateReportRequestCopyWith<$Res> {
  factory $GenerateReportRequestCopyWith(GenerateReportRequest value,
          $Res Function(GenerateReportRequest) then) =
      _$GenerateReportRequestCopyWithImpl<$Res, GenerateReportRequest>;
  @useResult
  $Res call(
      {String reportType,
      String period,
      DateTime? fromDate,
      DateTime? toDate,
      String? department,
      String? employeeId,
      Map<String, dynamic> parameters});
}

/// @nodoc
class _$GenerateReportRequestCopyWithImpl<$Res,
        $Val extends GenerateReportRequest>
    implements $GenerateReportRequestCopyWith<$Res> {
  _$GenerateReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportType = null,
    Object? period = null,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? department = freezed,
    Object? employeeId = freezed,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerateReportRequestImplCopyWith<$Res>
    implements $GenerateReportRequestCopyWith<$Res> {
  factory _$$GenerateReportRequestImplCopyWith(
          _$GenerateReportRequestImpl value,
          $Res Function(_$GenerateReportRequestImpl) then) =
      __$$GenerateReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String reportType,
      String period,
      DateTime? fromDate,
      DateTime? toDate,
      String? department,
      String? employeeId,
      Map<String, dynamic> parameters});
}

/// @nodoc
class __$$GenerateReportRequestImplCopyWithImpl<$Res>
    extends _$GenerateReportRequestCopyWithImpl<$Res,
        _$GenerateReportRequestImpl>
    implements _$$GenerateReportRequestImplCopyWith<$Res> {
  __$$GenerateReportRequestImplCopyWithImpl(_$GenerateReportRequestImpl _value,
      $Res Function(_$GenerateReportRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportType = null,
    Object? period = null,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? department = freezed,
    Object? employeeId = freezed,
    Object? parameters = null,
  }) {
    return _then(_$GenerateReportRequestImpl(
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateReportRequestImpl implements _GenerateReportRequest {
  const _$GenerateReportRequestImpl(
      {required this.reportType,
      required this.period,
      this.fromDate,
      this.toDate,
      this.department,
      this.employeeId,
      final Map<String, dynamic> parameters = const {}})
      : _parameters = parameters;

  factory _$GenerateReportRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerateReportRequestImplFromJson(json);

  @override
  final String reportType;
  @override
  final String period;
  @override
  final DateTime? fromDate;
  @override
  final DateTime? toDate;
  @override
  final String? department;
  @override
  final String? employeeId;
  final Map<String, dynamic> _parameters;
  @override
  @JsonKey()
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  String toString() {
    return 'GenerateReportRequest(reportType: $reportType, period: $period, fromDate: $fromDate, toDate: $toDate, department: $department, employeeId: $employeeId, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateReportRequestImpl &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reportType,
      period,
      fromDate,
      toDate,
      department,
      employeeId,
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateReportRequestImplCopyWith<_$GenerateReportRequestImpl>
      get copyWith => __$$GenerateReportRequestImplCopyWithImpl<
          _$GenerateReportRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateReportRequestImplToJson(
      this,
    );
  }
}

abstract class _GenerateReportRequest implements GenerateReportRequest {
  const factory _GenerateReportRequest(
      {required final String reportType,
      required final String period,
      final DateTime? fromDate,
      final DateTime? toDate,
      final String? department,
      final String? employeeId,
      final Map<String, dynamic> parameters}) = _$GenerateReportRequestImpl;

  factory _GenerateReportRequest.fromJson(Map<String, dynamic> json) =
      _$GenerateReportRequestImpl.fromJson;

  @override
  String get reportType;
  @override
  String get period;
  @override
  DateTime? get fromDate;
  @override
  DateTime? get toDate;
  @override
  String? get department;
  @override
  String? get employeeId;
  @override
  Map<String, dynamic> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$GenerateReportRequestImplCopyWith<_$GenerateReportRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) {
  return _ReportResponse.fromJson(json);
}

/// @nodoc
mixin _$ReportResponse {
  bool get success => throw _privateConstructorUsedError;
  ReportData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportResponseCopyWith<ReportResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportResponseCopyWith<$Res> {
  factory $ReportResponseCopyWith(
          ReportResponse value, $Res Function(ReportResponse) then) =
      _$ReportResponseCopyWithImpl<$Res, ReportResponse>;
  @useResult
  $Res call({bool success, ReportData? data, String? message, String? error});

  $ReportDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ReportResponseCopyWithImpl<$Res, $Val extends ReportResponse>
    implements $ReportResponseCopyWith<$Res> {
  _$ReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ReportData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReportDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ReportDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReportResponseImplCopyWith<$Res>
    implements $ReportResponseCopyWith<$Res> {
  factory _$$ReportResponseImplCopyWith(_$ReportResponseImpl value,
          $Res Function(_$ReportResponseImpl) then) =
      __$$ReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, ReportData? data, String? message, String? error});

  @override
  $ReportDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ReportResponseImplCopyWithImpl<$Res>
    extends _$ReportResponseCopyWithImpl<$Res, _$ReportResponseImpl>
    implements _$$ReportResponseImplCopyWith<$Res> {
  __$$ReportResponseImplCopyWithImpl(
      _$ReportResponseImpl _value, $Res Function(_$ReportResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ReportResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ReportData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportResponseImpl implements _ReportResponse {
  const _$ReportResponseImpl(
      {required this.success, this.data, this.message, this.error});

  factory _$ReportResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final ReportData? data;
  @override
  final String? message;
  @override
  final String? error;

  @override
  String toString() {
    return 'ReportResponse(success: $success, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportResponseImplCopyWith<_$ReportResponseImpl> get copyWith =>
      __$$ReportResponseImplCopyWithImpl<_$ReportResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportResponseImplToJson(
      this,
    );
  }
}

abstract class _ReportResponse implements ReportResponse {
  const factory _ReportResponse(
      {required final bool success,
      final ReportData? data,
      final String? message,
      final String? error}) = _$ReportResponseImpl;

  factory _ReportResponse.fromJson(Map<String, dynamic> json) =
      _$ReportResponseImpl.fromJson;

  @override
  bool get success;
  @override
  ReportData? get data;
  @override
  String? get message;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$ReportResponseImplCopyWith<_$ReportResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportsListResponse _$ReportsListResponseFromJson(Map<String, dynamic> json) {
  return _ReportsListResponse.fromJson(json);
}

/// @nodoc
mixin _$ReportsListResponse {
  bool get success => throw _privateConstructorUsedError;
  List<ReportData> get data => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportsListResponseCopyWith<ReportsListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportsListResponseCopyWith<$Res> {
  factory $ReportsListResponseCopyWith(
          ReportsListResponse value, $Res Function(ReportsListResponse) then) =
      _$ReportsListResponseCopyWithImpl<$Res, ReportsListResponse>;
  @useResult
  $Res call(
      {bool success,
      List<ReportData> data,
      int? total,
      int? page,
      int? limit,
      String? message,
      String? error});
}

/// @nodoc
class _$ReportsListResponseCopyWithImpl<$Res, $Val extends ReportsListResponse>
    implements $ReportsListResponseCopyWith<$Res> {
  _$ReportsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? limit = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReportData>,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportsListResponseImplCopyWith<$Res>
    implements $ReportsListResponseCopyWith<$Res> {
  factory _$$ReportsListResponseImplCopyWith(_$ReportsListResponseImpl value,
          $Res Function(_$ReportsListResponseImpl) then) =
      __$$ReportsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      List<ReportData> data,
      int? total,
      int? page,
      int? limit,
      String? message,
      String? error});
}

/// @nodoc
class __$$ReportsListResponseImplCopyWithImpl<$Res>
    extends _$ReportsListResponseCopyWithImpl<$Res, _$ReportsListResponseImpl>
    implements _$$ReportsListResponseImplCopyWith<$Res> {
  __$$ReportsListResponseImplCopyWithImpl(_$ReportsListResponseImpl _value,
      $Res Function(_$ReportsListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? limit = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ReportsListResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReportData>,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportsListResponseImpl implements _ReportsListResponse {
  const _$ReportsListResponseImpl(
      {required this.success,
      required final List<ReportData> data,
      this.total,
      this.page,
      this.limit,
      this.message,
      this.error})
      : _data = data;

  factory _$ReportsListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportsListResponseImplFromJson(json);

  @override
  final bool success;
  final List<ReportData> _data;
  @override
  List<ReportData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final String? message;
  @override
  final String? error;

  @override
  String toString() {
    return 'ReportsListResponse(success: $success, data: $data, total: $total, page: $page, limit: $limit, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportsListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      const DeepCollectionEquality().hash(_data),
      total,
      page,
      limit,
      message,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportsListResponseImplCopyWith<_$ReportsListResponseImpl> get copyWith =>
      __$$ReportsListResponseImplCopyWithImpl<_$ReportsListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportsListResponseImplToJson(
      this,
    );
  }
}

abstract class _ReportsListResponse implements ReportsListResponse {
  const factory _ReportsListResponse(
      {required final bool success,
      required final List<ReportData> data,
      final int? total,
      final int? page,
      final int? limit,
      final String? message,
      final String? error}) = _$ReportsListResponseImpl;

  factory _ReportsListResponse.fromJson(Map<String, dynamic> json) =
      _$ReportsListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  List<ReportData> get data;
  @override
  int? get total;
  @override
  int? get page;
  @override
  int? get limit;
  @override
  String? get message;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$ReportsListResponseImplCopyWith<_$ReportsListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportTypesResponse _$ReportTypesResponseFromJson(Map<String, dynamic> json) {
  return _ReportTypesResponse.fromJson(json);
}

/// @nodoc
mixin _$ReportTypesResponse {
  bool get success => throw _privateConstructorUsedError;
  List<ReportTypeData> get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportTypesResponseCopyWith<ReportTypesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportTypesResponseCopyWith<$Res> {
  factory $ReportTypesResponseCopyWith(
          ReportTypesResponse value, $Res Function(ReportTypesResponse) then) =
      _$ReportTypesResponseCopyWithImpl<$Res, ReportTypesResponse>;
  @useResult
  $Res call(
      {bool success,
      List<ReportTypeData> data,
      String? message,
      String? error});
}

/// @nodoc
class _$ReportTypesResponseCopyWithImpl<$Res, $Val extends ReportTypesResponse>
    implements $ReportTypesResponseCopyWith<$Res> {
  _$ReportTypesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReportTypeData>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportTypesResponseImplCopyWith<$Res>
    implements $ReportTypesResponseCopyWith<$Res> {
  factory _$$ReportTypesResponseImplCopyWith(_$ReportTypesResponseImpl value,
          $Res Function(_$ReportTypesResponseImpl) then) =
      __$$ReportTypesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      List<ReportTypeData> data,
      String? message,
      String? error});
}

/// @nodoc
class __$$ReportTypesResponseImplCopyWithImpl<$Res>
    extends _$ReportTypesResponseCopyWithImpl<$Res, _$ReportTypesResponseImpl>
    implements _$$ReportTypesResponseImplCopyWith<$Res> {
  __$$ReportTypesResponseImplCopyWithImpl(_$ReportTypesResponseImpl _value,
      $Res Function(_$ReportTypesResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ReportTypesResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReportTypeData>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportTypesResponseImpl implements _ReportTypesResponse {
  const _$ReportTypesResponseImpl(
      {required this.success,
      required final List<ReportTypeData> data,
      this.message,
      this.error})
      : _data = data;

  factory _$ReportTypesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportTypesResponseImplFromJson(json);

  @override
  final bool success;
  final List<ReportTypeData> _data;
  @override
  List<ReportTypeData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? message;
  @override
  final String? error;

  @override
  String toString() {
    return 'ReportTypesResponse(success: $success, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportTypesResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success,
      const DeepCollectionEquality().hash(_data), message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportTypesResponseImplCopyWith<_$ReportTypesResponseImpl> get copyWith =>
      __$$ReportTypesResponseImplCopyWithImpl<_$ReportTypesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportTypesResponseImplToJson(
      this,
    );
  }
}

abstract class _ReportTypesResponse implements ReportTypesResponse {
  const factory _ReportTypesResponse(
      {required final bool success,
      required final List<ReportTypeData> data,
      final String? message,
      final String? error}) = _$ReportTypesResponseImpl;

  factory _ReportTypesResponse.fromJson(Map<String, dynamic> json) =
      _$ReportTypesResponseImpl.fromJson;

  @override
  bool get success;
  @override
  List<ReportTypeData> get data;
  @override
  String? get message;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$ReportTypesResponseImplCopyWith<_$ReportTypesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeleteResponse _$DeleteResponseFromJson(Map<String, dynamic> json) {
  return _DeleteResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeleteResponseCopyWith<DeleteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteResponseCopyWith<$Res> {
  factory $DeleteResponseCopyWith(
          DeleteResponse value, $Res Function(DeleteResponse) then) =
      _$DeleteResponseCopyWithImpl<$Res, DeleteResponse>;
  @useResult
  $Res call({bool success, String? message, String? error});
}

/// @nodoc
class _$DeleteResponseCopyWithImpl<$Res, $Val extends DeleteResponse>
    implements $DeleteResponseCopyWith<$Res> {
  _$DeleteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeleteResponseImplCopyWith<$Res>
    implements $DeleteResponseCopyWith<$Res> {
  factory _$$DeleteResponseImplCopyWith(_$DeleteResponseImpl value,
          $Res Function(_$DeleteResponseImpl) then) =
      __$$DeleteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, String? error});
}

/// @nodoc
class __$$DeleteResponseImplCopyWithImpl<$Res>
    extends _$DeleteResponseCopyWithImpl<$Res, _$DeleteResponseImpl>
    implements _$$DeleteResponseImplCopyWith<$Res> {
  __$$DeleteResponseImplCopyWithImpl(
      _$DeleteResponseImpl _value, $Res Function(_$DeleteResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$DeleteResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteResponseImpl implements _DeleteResponse {
  const _$DeleteResponseImpl({required this.success, this.message, this.error});

  factory _$DeleteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  @override
  final String? error;

  @override
  String toString() {
    return 'DeleteResponse(success: $success, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteResponseImplCopyWith<_$DeleteResponseImpl> get copyWith =>
      __$$DeleteResponseImplCopyWithImpl<_$DeleteResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteResponseImplToJson(
      this,
    );
  }
}

abstract class _DeleteResponse implements DeleteResponse {
  const factory _DeleteResponse(
      {required final bool success,
      final String? message,
      final String? error}) = _$DeleteResponseImpl;

  factory _DeleteResponse.fromJson(Map<String, dynamic> json) =
      _$DeleteResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$DeleteResponseImplCopyWith<_$DeleteResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportData _$ReportDataFromJson(Map<String, dynamic> json) {
  return _ReportData.fromJson(json);
}

/// @nodoc
mixin _$ReportData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String get generatedBy => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportDataCopyWith<ReportData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportDataCopyWith<$Res> {
  factory $ReportDataCopyWith(
          ReportData value, $Res Function(ReportData) then) =
      _$ReportDataCopyWithImpl<$Res, ReportData>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      DateTime generatedAt,
      String generatedBy,
      Map<String, dynamic> parameters,
      String fileUrl,
      int fileSize,
      String? description,
      DateTime? expiresAt,
      String? status});
}

/// @nodoc
class _$ReportDataCopyWithImpl<$Res, $Val extends ReportData>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? generatedAt = null,
    Object? generatedBy = null,
    Object? parameters = null,
    Object? fileUrl = null,
    Object? fileSize = null,
    Object? description = freezed,
    Object? expiresAt = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      generatedBy: null == generatedBy
          ? _value.generatedBy
          : generatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportDataImplCopyWith<$Res>
    implements $ReportDataCopyWith<$Res> {
  factory _$$ReportDataImplCopyWith(
          _$ReportDataImpl value, $Res Function(_$ReportDataImpl) then) =
      __$$ReportDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      DateTime generatedAt,
      String generatedBy,
      Map<String, dynamic> parameters,
      String fileUrl,
      int fileSize,
      String? description,
      DateTime? expiresAt,
      String? status});
}

/// @nodoc
class __$$ReportDataImplCopyWithImpl<$Res>
    extends _$ReportDataCopyWithImpl<$Res, _$ReportDataImpl>
    implements _$$ReportDataImplCopyWith<$Res> {
  __$$ReportDataImplCopyWithImpl(
      _$ReportDataImpl _value, $Res Function(_$ReportDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? generatedAt = null,
    Object? generatedBy = null,
    Object? parameters = null,
    Object? fileUrl = null,
    Object? fileSize = null,
    Object? description = freezed,
    Object? expiresAt = freezed,
    Object? status = freezed,
  }) {
    return _then(_$ReportDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      generatedBy: null == generatedBy
          ? _value.generatedBy
          : generatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportDataImpl implements _ReportData {
  const _$ReportDataImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.generatedAt,
      required this.generatedBy,
      required final Map<String, dynamic> parameters,
      required this.fileUrl,
      required this.fileSize,
      this.description,
      this.expiresAt,
      this.status})
      : _parameters = parameters;

  factory _$ReportDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportDataImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final DateTime generatedAt;
  @override
  final String generatedBy;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  final String fileUrl;
  @override
  final int fileSize;
  @override
  final String? description;
  @override
  final DateTime? expiresAt;
  @override
  final String? status;

  @override
  String toString() {
    return 'ReportData(id: $id, name: $name, type: $type, generatedAt: $generatedAt, generatedBy: $generatedBy, parameters: $parameters, fileUrl: $fileUrl, fileSize: $fileSize, description: $description, expiresAt: $expiresAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.generatedBy, generatedBy) ||
                other.generatedBy == generatedBy) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      generatedAt,
      generatedBy,
      const DeepCollectionEquality().hash(_parameters),
      fileUrl,
      fileSize,
      description,
      expiresAt,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      __$$ReportDataImplCopyWithImpl<_$ReportDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportDataImplToJson(
      this,
    );
  }
}

abstract class _ReportData implements ReportData {
  const factory _ReportData(
      {required final String id,
      required final String name,
      required final String type,
      required final DateTime generatedAt,
      required final String generatedBy,
      required final Map<String, dynamic> parameters,
      required final String fileUrl,
      required final int fileSize,
      final String? description,
      final DateTime? expiresAt,
      final String? status}) = _$ReportDataImpl;

  factory _ReportData.fromJson(Map<String, dynamic> json) =
      _$ReportDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  DateTime get generatedAt;
  @override
  String get generatedBy;
  @override
  Map<String, dynamic> get parameters;
  @override
  String get fileUrl;
  @override
  int get fileSize;
  @override
  String? get description;
  @override
  DateTime? get expiresAt;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$ReportDataImplCopyWith<_$ReportDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportTypeData _$ReportTypeDataFromJson(Map<String, dynamic> json) {
  return _ReportTypeData.fromJson(json);
}

/// @nodoc
mixin _$ReportTypeData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get requiredParameters => throw _privateConstructorUsedError;
  List<String> get optionalParameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportTypeDataCopyWith<ReportTypeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportTypeDataCopyWith<$Res> {
  factory $ReportTypeDataCopyWith(
          ReportTypeData value, $Res Function(ReportTypeData) then) =
      _$ReportTypeDataCopyWithImpl<$Res, ReportTypeData>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> requiredParameters,
      List<String> optionalParameters});
}

/// @nodoc
class _$ReportTypeDataCopyWithImpl<$Res, $Val extends ReportTypeData>
    implements $ReportTypeDataCopyWith<$Res> {
  _$ReportTypeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? requiredParameters = null,
    Object? optionalParameters = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requiredParameters: null == requiredParameters
          ? _value.requiredParameters
          : requiredParameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionalParameters: null == optionalParameters
          ? _value.optionalParameters
          : optionalParameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportTypeDataImplCopyWith<$Res>
    implements $ReportTypeDataCopyWith<$Res> {
  factory _$$ReportTypeDataImplCopyWith(_$ReportTypeDataImpl value,
          $Res Function(_$ReportTypeDataImpl) then) =
      __$$ReportTypeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> requiredParameters,
      List<String> optionalParameters});
}

/// @nodoc
class __$$ReportTypeDataImplCopyWithImpl<$Res>
    extends _$ReportTypeDataCopyWithImpl<$Res, _$ReportTypeDataImpl>
    implements _$$ReportTypeDataImplCopyWith<$Res> {
  __$$ReportTypeDataImplCopyWithImpl(
      _$ReportTypeDataImpl _value, $Res Function(_$ReportTypeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? requiredParameters = null,
    Object? optionalParameters = null,
  }) {
    return _then(_$ReportTypeDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requiredParameters: null == requiredParameters
          ? _value._requiredParameters
          : requiredParameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionalParameters: null == optionalParameters
          ? _value._optionalParameters
          : optionalParameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportTypeDataImpl implements _ReportTypeData {
  const _$ReportTypeDataImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<String> requiredParameters,
      required final List<String> optionalParameters})
      : _requiredParameters = requiredParameters,
        _optionalParameters = optionalParameters;

  factory _$ReportTypeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportTypeDataImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final List<String> _requiredParameters;
  @override
  List<String> get requiredParameters {
    if (_requiredParameters is EqualUnmodifiableListView)
      return _requiredParameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredParameters);
  }

  final List<String> _optionalParameters;
  @override
  List<String> get optionalParameters {
    if (_optionalParameters is EqualUnmodifiableListView)
      return _optionalParameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionalParameters);
  }

  @override
  String toString() {
    return 'ReportTypeData(id: $id, name: $name, description: $description, requiredParameters: $requiredParameters, optionalParameters: $optionalParameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportTypeDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._requiredParameters, _requiredParameters) &&
            const DeepCollectionEquality()
                .equals(other._optionalParameters, _optionalParameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_requiredParameters),
      const DeepCollectionEquality().hash(_optionalParameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportTypeDataImplCopyWith<_$ReportTypeDataImpl> get copyWith =>
      __$$ReportTypeDataImplCopyWithImpl<_$ReportTypeDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportTypeDataImplToJson(
      this,
    );
  }
}

abstract class _ReportTypeData implements ReportTypeData {
  const factory _ReportTypeData(
      {required final String id,
      required final String name,
      required final String description,
      required final List<String> requiredParameters,
      required final List<String> optionalParameters}) = _$ReportTypeDataImpl;

  factory _ReportTypeData.fromJson(Map<String, dynamic> json) =
      _$ReportTypeDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get requiredParameters;
  @override
  List<String> get optionalParameters;
  @override
  @JsonKey(ignore: true)
  _$$ReportTypeDataImplCopyWith<_$ReportTypeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
