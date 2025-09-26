// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return _Employee.fromJson(json);
}

/// @nodoc
mixin _$Employee {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isClockedIn => throw _privateConstructorUsedError;
  DateTime? get lastClockIn => throw _privateConstructorUsedError;
  DateTime? get lastClockOut => throw _privateConstructorUsedError;
  DateTime? get hireDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeCopyWith<Employee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeCopyWith<$Res> {
  factory $EmployeeCopyWith(Employee value, $Res Function(Employee) then) =
      _$EmployeeCopyWithImpl<$Res, Employee>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String department,
      String position,
      String? phoneNumber,
      String? avatarUrl,
      bool isActive,
      bool isClockedIn,
      DateTime? lastClockIn,
      DateTime? lastClockOut,
      DateTime? hireDate,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$EmployeeCopyWithImpl<$Res, $Val extends Employee>
    implements $EmployeeCopyWith<$Res> {
  _$EmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? department = null,
    Object? position = null,
    Object? phoneNumber = freezed,
    Object? avatarUrl = freezed,
    Object? isActive = null,
    Object? isClockedIn = null,
    Object? lastClockIn = freezed,
    Object? lastClockOut = freezed,
    Object? hireDate = freezed,
    Object? metadata = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isClockedIn: null == isClockedIn
          ? _value.isClockedIn
          : isClockedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      lastClockIn: freezed == lastClockIn
          ? _value.lastClockIn
          : lastClockIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastClockOut: freezed == lastClockOut
          ? _value.lastClockOut
          : lastClockOut // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hireDate: freezed == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeImplCopyWith<$Res>
    implements $EmployeeCopyWith<$Res> {
  factory _$$EmployeeImplCopyWith(
          _$EmployeeImpl value, $Res Function(_$EmployeeImpl) then) =
      __$$EmployeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String department,
      String position,
      String? phoneNumber,
      String? avatarUrl,
      bool isActive,
      bool isClockedIn,
      DateTime? lastClockIn,
      DateTime? lastClockOut,
      DateTime? hireDate,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$EmployeeImplCopyWithImpl<$Res>
    extends _$EmployeeCopyWithImpl<$Res, _$EmployeeImpl>
    implements _$$EmployeeImplCopyWith<$Res> {
  __$$EmployeeImplCopyWithImpl(
      _$EmployeeImpl _value, $Res Function(_$EmployeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? department = null,
    Object? position = null,
    Object? phoneNumber = freezed,
    Object? avatarUrl = freezed,
    Object? isActive = null,
    Object? isClockedIn = null,
    Object? lastClockIn = freezed,
    Object? lastClockOut = freezed,
    Object? hireDate = freezed,
    Object? metadata = null,
  }) {
    return _then(_$EmployeeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isClockedIn: null == isClockedIn
          ? _value.isClockedIn
          : isClockedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      lastClockIn: freezed == lastClockIn
          ? _value.lastClockIn
          : lastClockIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastClockOut: freezed == lastClockOut
          ? _value.lastClockOut
          : lastClockOut // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hireDate: freezed == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeImpl implements _Employee {
  const _$EmployeeImpl(
      {required this.id,
      required this.name,
      required this.email,
      required this.department,
      required this.position,
      this.phoneNumber,
      this.avatarUrl,
      this.isActive = false,
      this.isClockedIn = false,
      this.lastClockIn,
      this.lastClockOut,
      this.hireDate,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$EmployeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String department;
  @override
  final String position;
  @override
  final String? phoneNumber;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isClockedIn;
  @override
  final DateTime? lastClockIn;
  @override
  final DateTime? lastClockOut;
  @override
  final DateTime? hireDate;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, email: $email, department: $department, position: $position, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, isActive: $isActive, isClockedIn: $isClockedIn, lastClockIn: $lastClockIn, lastClockOut: $lastClockOut, hireDate: $hireDate, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isClockedIn, isClockedIn) ||
                other.isClockedIn == isClockedIn) &&
            (identical(other.lastClockIn, lastClockIn) ||
                other.lastClockIn == lastClockIn) &&
            (identical(other.lastClockOut, lastClockOut) ||
                other.lastClockOut == lastClockOut) &&
            (identical(other.hireDate, hireDate) ||
                other.hireDate == hireDate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      department,
      position,
      phoneNumber,
      avatarUrl,
      isActive,
      isClockedIn,
      lastClockIn,
      lastClockOut,
      hireDate,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeImplCopyWith<_$EmployeeImpl> get copyWith =>
      __$$EmployeeImplCopyWithImpl<_$EmployeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeImplToJson(
      this,
    );
  }
}

abstract class _Employee implements Employee {
  const factory _Employee(
      {required final String id,
      required final String name,
      required final String email,
      required final String department,
      required final String position,
      final String? phoneNumber,
      final String? avatarUrl,
      final bool isActive,
      final bool isClockedIn,
      final DateTime? lastClockIn,
      final DateTime? lastClockOut,
      final DateTime? hireDate,
      final Map<String, dynamic> metadata}) = _$EmployeeImpl;

  factory _Employee.fromJson(Map<String, dynamic> json) =
      _$EmployeeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get department;
  @override
  String get position;
  @override
  String? get phoneNumber;
  @override
  String? get avatarUrl;
  @override
  bool get isActive;
  @override
  bool get isClockedIn;
  @override
  DateTime? get lastClockIn;
  @override
  DateTime? get lastClockOut;
  @override
  DateTime? get hireDate;
  @override
  Map<String, dynamic> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeImplCopyWith<_$EmployeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
