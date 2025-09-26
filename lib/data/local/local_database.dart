// lib/data/datasources/local/local_database.dart
import 'package:employee_admin_dashboard/data/models/department.dart';
import 'package:employee_admin_dashboard/data/models/employee.dart';
import 'package:employee_admin_dashboard/data/models/time_record.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocalDatabase {
  static const String employeeBoxName = 'employees';
  static const String timeRecordBoxName = 'time_records';
  static const String departmentBoxName = 'departments';
  static const String settingsBoxName = 'settings';

  late Box<Employee> _employeeBox;
  late Box<TimeRecord> _timeRecordBox;
  late Box<Department> _departmentBox;
  late Box<Map<String, dynamic>> _settingsBox;

  static Future<LocalDatabase> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EmployeeAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TimeRecordAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(DepartmentAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TimeRecordStatusAdapter());
    }

    final database = LocalDatabase();
    await database._openBoxes();
    return database;
  }

  Future<void> _openBoxes() async {
    _employeeBox = await Hive.openBox<Employee>(employeeBoxName);
    _timeRecordBox = await Hive.openBox<TimeRecord>(timeRecordBoxName);
    _departmentBox = await Hive.openBox<Department>(departmentBoxName);
    _settingsBox = await Hive.openBox<Map<String, dynamic>>(settingsBoxName);
  }

  // Employee operations
  Future<void> saveEmployee(Employee employee) async {
    await _employeeBox.put(employee.id, employee);
  }

  Future<void> saveEmployees(List<Employee> employees) async {
    final Map<String, Employee> employeeMap = {};
    for (final employee in employees) {
      employeeMap[employee.id] = employee;
    }
    await _employeeBox.putAll(employeeMap);
  }

  Employee? getEmployee(String id) {
    return _employeeBox.get(id);
  }

  List<Employee> getAllEmployees() {
    return _employeeBox.values.toList();
  }

  Future<void> deleteEmployee(String id) async {
    await _employeeBox.delete(id);
  }

  List<Employee> searchEmployees(String query) {
    final allEmployees = getAllEmployees();
    return allEmployees.where((employee) =>
        employee.name.toLowerCase().contains(query.toLowerCase()) ||
        employee.department.toLowerCase().contains(query.toLowerCase()) ||
        employee.position.toLowerCase().contains(query.toLowerCase()) ||
        employee.email.toLowerCase().contains(query.toLowerCase())).toList();
  }

  // Time Record operations
  Future<void> saveTimeRecord(TimeRecord record) async {
    await _timeRecordBox.put(record.id, record);
  }

  Future<void> saveTimeRecords(List<TimeRecord> records) async {
    final Map<String, TimeRecord> recordMap = {};
    for (final record in records) {
      recordMap[record.id] = record;
    }
    await _timeRecordBox.putAll(recordMap);
  }

  TimeRecord? getTimeRecord(String id) {
    return _timeRecordBox.get(id);
  }

  List<TimeRecord> getAllTimeRecords() {
    return _timeRecordBox.values.toList();
  }

  List<TimeRecord> getTimeRecordsByEmployee(String employeeId) {
    return _timeRecordBox.values
        .where((record) => record.employeeId == employeeId)
        .toList();
  }

  List<TimeRecord> getTimeRecordsByDateRange(DateTime start, DateTime end) {
    return _timeRecordBox.values
        .where((record) =>
            record.clockIn.isAfter(start) && record.clockIn.isBefore(end))
        .toList();
  }

  Future<void> deleteTimeRecord(String id) async {
    await _timeRecordBox.delete(id);
  }

  // Department operations
  Future<void> saveDepartment(Department department) async {
    await _departmentBox.put(department.id, department);
  }

  Department? getDepartment(String id) {
    return _departmentBox.get(id);
  }

  List<Department> getAllDepartments() {
    return _departmentBox.values.toList();
  }

  Future<void> deleteDepartment(String id) async {
    await _departmentBox.delete(id);
  }

  // Settings operations
  Future<void> saveSetting(String key, Map<String, dynamic> value) async {
    await _settingsBox.put(key, value);
  }

  Map<String, dynamic>? getSetting(String key) {
    return _settingsBox.get(key);
  }

  // Analytics and Statistics
  Future<Map<String, int>> getEmployeeStatistics() async {
    final employees = getAllEmployees();
    final totalEmployees = employees.length;
    final activeEmployees = employees.where((e) => e.isActive).length;
    final clockedInEmployees = employees.where((e) => e.isClockedIn).length;

    return {
      'total': totalEmployees,
      'active': activeEmployees,
      'clockedIn': clockedInEmployees,
      'clockedOut': activeEmployees - clockedInEmployees,
    };
  }

  Future<List<Map<String, dynamic>>> getDepartmentStatistics() async {
    final departments = getAllDepartments();
    final employees = getAllEmployees();
    
    return departments.map((dept) {
      final deptEmployees = employees.where((e) => e.department == dept.name).toList();
      final activeDeptEmployees = deptEmployees.where((e) => e.isActive).length;
      final clockedInDeptEmployees = deptEmployees.where((e) => e.isClockedIn).length;

      return {
        'department': dept.name,
        'totalEmployees': deptEmployees.length,
        'activeEmployees': activeDeptEmployees,
        'clockedIn': clockedInDeptEmployees,
      };
    }).toList();
  }

  // Backup and restore
  Future<Map<String, dynamic>> exportData() async {
    return {
      'employees': getAllEmployees().map((e) => e.toJson()).toList(),
      'timeRecords': getAllTimeRecords().map((r) => r.toJson()).toList(),
      'departments': getAllDepartments().map((d) => d.toJson()).toList(),
      'exportedAt': DateTime.now().toIso8601String(),
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    // Clear existing data
    await _employeeBox.clear();
    await _timeRecordBox.clear();
    await _departmentBox.clear();

    // Import employees
    if (data['employees'] != null) {
      final employees = (data['employees'] as List)
          .map((json) => Employee.fromJson(json))
          .toList();
      await saveEmployees(employees);
    }

    // Import time records
    if (data['timeRecords'] != null) {
      final timeRecords = (data['timeRecords'] as List)
          .map((json) => TimeRecord.fromJson(json))
          .toList();
      await saveTimeRecords(timeRecords);
    }

    // Import departments
    if (data['departments'] != null) {
      final departments = (data['departments'] as List)
          .map((json) => Department.fromJson(json))
          .toList();
      for (final dept in departments) {
        await saveDepartment(dept);
      }
    }
  }

  // Close database
  Future<void> close() async {
    await _employeeBox.close();
    await _timeRecordBox.close();
    await _departmentBox.close();
    await _settingsBox.close();
  }

  // Seed initial data for demo
  Future<void> seedInitialData() async {
    final existingEmployees = getAllEmployees();
    if (existingEmployees.isEmpty) {
      await _seedDepartments();
      await _seedEmployees();
      await _seedTimeRecords();
    }
  }

  Future<void> _seedDepartments() async {
    final departments = [
      Department(
        id: 'dept_1',
        name: 'Engineering',
        description: 'Software development and technical operations',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_2',
        name: 'Marketing',
        description: 'Marketing and brand management',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_3',
        name: 'Sales',
        description: 'Sales and customer relations',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_4',
        name: 'Human Resources',
        description: 'HR and employee management',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_5',
        name: 'Software',
        description: 'Software development and programming',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_6',
        name: 'Telecom',
        description: 'Telecommunications and network operations',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_7',
        name: 'IT Infra',
        description: 'IT infrastructure and systems administration',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      Department(
        id: 'dept_8',
        name: 'Installation',
        description: 'System installation and deployment',
        isActive: true,
        createdAt: DateTime.now(),
      ),
    ];

    for (final dept in departments) {
      await saveDepartment(dept);
    }
  }

  Future<void> _seedEmployees() async {
    final employees = [
      Employee(
        id: 'emp_001',
        name: 'John Doe',
        email: 'john.doe@company.com',
        department: 'Engineering',
        position: 'Senior Software Developer',
        phoneNumber: '+1-234-567-8901',
        isActive: true,
        isClockedIn: true,
        lastClockIn: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)),
        hireDate: DateTime.now().subtract(const Duration(days: 365)),
      ),
      Employee(
        id: 'emp_002',
        name: 'Jane Smith',
        email: 'jane.smith@company.com',
        department: 'Marketing',
        position: 'Marketing Manager',
        phoneNumber: '+1-234-567-8902',
        isActive: true,
        isClockedIn: false,
        lastClockOut: DateTime.now().subtract(const Duration(minutes: 45)),
        hireDate: DateTime.now().subtract(const Duration(days: 730)),
      ),
      Employee(
        id: 'emp_003',
        name: 'Mike Johnson',
        email: 'mike.johnson@company.com',
        department: 'Sales',
        position: 'Sales Executive',
        phoneNumber: '+1-234-567-8903',
        isActive: true,
        isClockedIn: true,
        lastClockIn: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
        hireDate: DateTime.now().subtract(const Duration(days: 180)),
      ),
      Employee(
        id: 'emp_004',
        name: 'Sarah Wilson',
        email: 'sarah.wilson@company.com',
        department: 'Human Resources',
        position: 'HR Specialist',
        phoneNumber: '+1-234-567-8904',
        isActive: true,
        isClockedIn: false,
        lastClockOut: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
        hireDate: DateTime.now().subtract(const Duration(days: 450)),
      ),
      Employee(
        id: 'emp_005',
        name: 'David Brown',
        email: 'david.brown@company.com',
        department: 'Engineering',
        position: 'DevOps Engineer',
        phoneNumber: '+1-234-567-8905',
        isActive: true,
        isClockedIn: true,
        lastClockIn: DateTime.now().subtract(const Duration(hours: 4, minutes: 45)),
        hireDate: DateTime.now().subtract(const Duration(days: 280)),
      ),
    ];

    await saveEmployees(employees);
  }

  Future<void> _seedTimeRecords() async {
    final now = DateTime.now();
    final timeRecords = [
      // John Doe records
      TimeRecord(
        id: 'tr_001',
        employeeId: 'emp_001',
        clockIn: now.subtract(const Duration(days: 1, hours: 8)),
        clockOut: now.subtract(const Duration(days: 1)),
        totalDuration: const Duration(hours: 8),
        status: TimeRecordStatus.completed,
        createdAt: now.subtract(const Duration(days: 1, hours: 8)),
      ),
      TimeRecord(
        id: 'tr_002',
        employeeId: 'emp_001',
        clockIn: now.subtract(const Duration(hours: 3, minutes: 30)),
        status: TimeRecordStatus.active,
        createdAt: now.subtract(const Duration(hours: 3, minutes: 30)),
      ),
      
      // Jane Smith records
      TimeRecord(
        id: 'tr_003',
        employeeId: 'emp_002',
        clockIn: now.subtract(const Duration(days: 1, hours: 8, minutes: 15)),
        clockOut: now.subtract(const Duration(days: 1, minutes: 45)),
        totalDuration: const Duration(hours: 7, minutes: 30),
        status: TimeRecordStatus.completed,
        createdAt: now.subtract(const Duration(days: 1, hours: 8, minutes: 15)),
      ),
      
      // Mike Johnson records
      TimeRecord(
        id: 'tr_004',
        employeeId: 'emp_003',
        clockIn: now.subtract(const Duration(hours: 2, minutes: 15)),
        status: TimeRecordStatus.active,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 15)),
      ),
    ];

    await saveTimeRecords(timeRecords);
  }
}

// Hive Type Adapters
class EmployeeAdapter extends TypeAdapter<Employee> {
  @override
  final int typeId = 0;

  @override
  Employee read(BinaryReader reader) {
    return Employee.fromJson(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, Employee obj) {
    writer.writeMap(obj.toJson());
  }
}

class TimeRecordAdapter extends TypeAdapter<TimeRecord> {
  @override
  final int typeId = 1;

  @override
  TimeRecord read(BinaryReader reader) {
    return TimeRecord.fromJson(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, TimeRecord obj) {
    writer.writeMap(obj.toJson());
  }
}

class DepartmentAdapter extends TypeAdapter<Department> {
  @override
  final int typeId = 2;

  @override
  Department read(BinaryReader reader) {
    return Department.fromJson(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, Department obj) {
    writer.writeMap(obj.toJson());
  }
}

class TimeRecordStatusAdapter extends TypeAdapter<TimeRecordStatus> {
  @override
  final int typeId = 3;

  @override
  TimeRecordStatus read(BinaryReader reader) {
    final value = reader.readString();
    return TimeRecordStatus.values.firstWhere(
      (status) => status.toString() == value,
      orElse: () => TimeRecordStatus.active,
    );
  }

  @override
  void write(BinaryWriter writer, TimeRecordStatus obj) {
    writer.writeString(obj.toString());
  }
}