// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeRecord _$TimeRecordFromJson(Map<String, dynamic> json) {
  return _TimeRecord.fromJson(json);
}

/// @nodoc
mixin _$TimeRecord {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  DateTime get clockIn => throw _privateConstructorUsedError;
  DateTime? get clockOut => throw _privateConstructorUsedError;
  Duration? get totalDuration => throw _privateConstructorUsedError;
  TimeRecordStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeRecordCopyWith<TimeRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeRecordCopyWith<$Res> {
  factory $TimeRecordCopyWith(
          TimeRecord value, $Res Function(TimeRecord) then) =
      _$TimeRecordCopyWithImpl<$Res, TimeRecord>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      DateTime clockIn,
      DateTime? clockOut,
      Duration? totalDuration,
      TimeRecordStatus status,
      String? notes,
      String? location,
      Map<String, dynamic> metadata,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$TimeRecordCopyWithImpl<$Res, $Val extends TimeRecord>
    implements $TimeRecordCopyWith<$Res> {
  _$TimeRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? clockIn = null,
    Object? clockOut = freezed,
    Object? totalDuration = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? location = freezed,
    Object? metadata = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      clockIn: null == clockIn
          ? _value.clockIn
          : clockIn // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
              as TimeRecordStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeRecordImplCopyWith<$Res>
    implements $TimeRecordCopyWith<$Res> {
  factory _$$TimeRecordImplCopyWith(
          _$TimeRecordImpl value, $Res Function(_$TimeRecordImpl) then) =
      __$$TimeRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      DateTime clockIn,
      DateTime? clockOut,
      Duration? totalDuration,
      TimeRecordStatus status,
      String? notes,
      String? location,
      Map<String, dynamic> metadata,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$TimeRecordImplCopyWithImpl<$Res>
    extends _$TimeRecordCopyWithImpl<$Res, _$TimeRecordImpl>
    implements _$$TimeRecordImplCopyWith<$Res> {
  __$$TimeRecordImplCopyWithImpl(
      _$TimeRecordImpl _value, $Res Function(_$TimeRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? clockIn = null,
    Object? clockOut = freezed,
    Object? totalDuration = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? location = freezed,
    Object? metadata = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TimeRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      clockIn: null == clockIn
          ? _value.clockIn
          : clockIn // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
              as TimeRecordStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeRecordImpl implements _TimeRecord {
  const _$TimeRecordImpl(
      {required this.id,
      required this.employeeId,
      required this.clockIn,
      this.clockOut,
      this.totalDuration,
      this.status = TimeRecordStatus.active,
      this.notes,
      this.location,
      final Map<String, dynamic> metadata = const {},
      this.createdAt,
      this.updatedAt})
      : _metadata = metadata;

  factory _$TimeRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final DateTime clockIn;
  @override
  final DateTime? clockOut;
  @override
  final Duration? totalDuration;
  @override
  @JsonKey()
  final TimeRecordStatus status;
  @override
  final String? notes;
  @override
  final String? location;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TimeRecord(id: $id, employeeId: $employeeId, clockIn: $clockIn, clockOut: $clockOut, totalDuration: $totalDuration, status: $status, notes: $notes, location: $location, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.clockIn, clockIn) || other.clockIn == clockIn) &&
            (identical(other.clockOut, clockOut) ||
                other.clockOut == clockOut) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      employeeId,
      clockIn,
      clockOut,
      totalDuration,
      status,
      notes,
      location,
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeRecordImplCopyWith<_$TimeRecordImpl> get copyWith =>
      __$$TimeRecordImplCopyWithImpl<_$TimeRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeRecordImplToJson(
      this,
    );
  }
}

abstract class _TimeRecord implements TimeRecord {
  const factory _TimeRecord(
      {required final String id,
      required final String employeeId,
      required final DateTime clockIn,
      final DateTime? clockOut,
      final Duration? totalDuration,
      final TimeRecordStatus status,
      final String? notes,
      final String? location,
      final Map<String, dynamic> metadata,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$TimeRecordImpl;

  factory _TimeRecord.fromJson(Map<String, dynamic> json) =
      _$TimeRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  DateTime get clockIn;
  @override
  DateTime? get clockOut;
  @override
  Duration? get totalDuration;
  @override
  TimeRecordStatus get status;
  @override
  String? get notes;
  @override
  String? get location;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TimeRecordImplCopyWith<_$TimeRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
