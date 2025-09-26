class EmployeeEntity {
  final String id;
  final String name;
  final String email;
  final String department;
  final String position;
  final String? phoneNumber;
  final String? avatarUrl;
  final bool isActive;
  final bool isClockedIn;
  final DateTime? lastClockIn;
  final DateTime? lastClockOut;
  final DateTime? hireDate;

  const EmployeeEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.position,
    this.phoneNumber,
    this.avatarUrl,
    required this.isActive,
    required this.isClockedIn,
    this.lastClockIn,
    this.lastClockOut,
    this.hireDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}