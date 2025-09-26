

// FIXED: Employee model with proper LinkedMap handling
class Employee {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? department;
  final String? position;
  final String? address;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.department,
    this.position,
    this.address,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  // CRITICAL FIX: Safe fromJson that handles LinkedMap
  factory Employee.fromJson(dynamic json) {
    try {
      // Convert any Map type to Map<String, dynamic>
      final Map<String, dynamic> data = _safeMapConversion(json);
      
      return Employee(
        id: _safeString(data['_id'] ?? data['id']),
        name: _safeString(data['name']),
        email: _safeString(data['email']),
        phone: _safeStringNullable(data['phone']),
        department: _safeStringNullable(data['department']),
        position: _safeStringNullable(data['position']),
        address: _safeStringNullable(data['address']),
        isActive: data['isActive'] == true,
        createdAt: _safeDateTime(data['createdAt']),
        updatedAt: _safeDateTime(data['updatedAt']),
      );
    } catch (e) {
      throw Exception('Failed to parse Employee from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'position': position,
      'address': address,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? department,
    String? position,
    String? address,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      position: position ?? this.position,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper method for creating a list from JSON
  static List<Employee> fromJsonList(dynamic jsonList) {
    if (jsonList is! List) {
      return [];
    }
    
    return jsonList
        .map((json) {
          try {
            return Employee.fromJson(json);
          } catch (e) {
            // Error parsing employee: $e
            return null;
          }
        })
        .where((employee) => employee != null)
        .cast<Employee>()
        .toList();
  }
}

// FIXED: AttendanceRecord model with proper LinkedMap handling
class AttendanceRecord {
  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime loginTime;
  final DateTime? logoutTime;
  final bool isActive;
  final String? loginAddress;
  final String? logoutAddress;
  final String? reason;
  final Duration? workDuration;

  AttendanceRecord({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.loginTime,
    this.logoutTime,
    required this.isActive,
    this.loginAddress,
    this.logoutAddress,
    this.reason,
    this.workDuration,
  });

  // CRITICAL FIX: Safe fromJson that handles LinkedMap
  factory AttendanceRecord.fromJson(dynamic json) {
    try {
      // Convert any Map type to Map<String, dynamic>
      final Map<String, dynamic> data = _safeMapConversion(json);
      
      final loginTime = _safeDateTime(data['loginTime']) ?? DateTime.now();
      final logoutTime = _safeDateTime(data['logoutTime']);
      
      // Calculate work duration if both login and logout times exist
      Duration? workDuration;
      if (logoutTime != null) {
        workDuration = logoutTime.difference(loginTime);
      }

      return AttendanceRecord(
        id: _safeString(data['_id'] ?? data['id']),
        employeeId: _safeString(data['employeeId']),
        employeeName: _safeString(data['employeeName'] ?? data['employee']?['name']),
        loginTime: loginTime,
        logoutTime: logoutTime,
        isActive: data['isActive'] == true,
        loginAddress: _safeStringNullable(data['loginAddress']),
        logoutAddress: _safeStringNullable(data['logoutAddress']),
        reason: _safeStringNullable(data['reason']),
        workDuration: workDuration,
      );
    } catch (e) {
      throw Exception('Failed to parse AttendanceRecord from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'loginTime': loginTime.toIso8601String(),
      'logoutTime': logoutTime?.toIso8601String(),
      'isActive': isActive,
      'loginAddress': loginAddress,
      'logoutAddress': logoutAddress,
      'reason': reason,
      'workDuration': workDuration?.inMinutes,
    };
  }

  // Helper method to get formatted duration
  String get formattedDuration {
    final duration = workDuration ?? 
        (isActive ? DateTime.now().difference(loginTime) : Duration.zero);
    
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  // Helper method for creating a list from JSON
  static List<AttendanceRecord> fromJsonList(dynamic jsonList) {
    if (jsonList is! List) {
      return [];
    }
    
    return jsonList
        .map((json) {
          try {
            return AttendanceRecord.fromJson(json);
          } catch (e) {
            // Error parsing attendance record: $e
            return null;
          }
        })
        .where((record) => record != null)
        .cast<AttendanceRecord>()
        .toList();
  }
}

// FIXED: Movement record model
class MovementRecord {
  final String id;
  final String employeeId;
  final String employeeName;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime timestamp;
  final String? reason;

  MovementRecord({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.timestamp,
    this.reason,
  });

  factory MovementRecord.fromJson(dynamic json) {
    try {
      final Map<String, dynamic> data = _safeMapConversion(json);
      
      return MovementRecord(
        id: _safeString(data['_id'] ?? data['id']),
        employeeId: _safeString(data['employeeId']),
        employeeName: _safeString(data['employeeName'] ?? data['employee']?['name']),
        latitude: _safeDouble(data['latitude']),
        longitude: _safeDouble(data['longitude']),
        address: _safeString(data['address']),
        timestamp: _safeDateTime(data['timestamp']) ?? DateTime.now(),
        reason: _safeStringNullable(data['reason']),
      );
    } catch (e) {
      throw Exception('Failed to parse MovementRecord from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'timestamp': timestamp.toIso8601String(),
      'reason': reason,
    };
  }

  static List<MovementRecord> fromJsonList(dynamic jsonList) {
    if (jsonList is! List) {
      return [];
    }
    
    return jsonList
        .map((json) {
          try {
            return MovementRecord.fromJson(json);
          } catch (e) {
            // Error parsing movement record: $e
            return null;
          }
        })
        .where((record) => record != null)
        .cast<MovementRecord>()
        .toList();
  }
}

// ========================================
// UTILITY FUNCTIONS FOR SAFE CONVERSION
// ========================================

// CRITICAL: Safe map conversion to prevent LinkedMap issues
Map<String, dynamic> _safeMapConversion(dynamic input) {
  if (input is Map<String, dynamic>) {
    return input;
  } else if (input is Map) {
    final Map<String, dynamic> result = {};
    input.forEach((key, value) {
      String stringKey = key.toString();
      if (value is Map) {
        result[stringKey] = _safeMapConversion(value);
      } else if (value is List) {
        result[stringKey] = value.map((item) => 
          item is Map ? _safeMapConversion(item) : item
        ).toList();
      } else {
        result[stringKey] = value;
      }
    });
    return result;
  } else {
    throw ArgumentError('Expected Map, got ${input.runtimeType}');
  }
}

// Safe string conversion
String _safeString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

String? _safeStringNullable(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

// Safe DateTime conversion
DateTime? _safeDateTime(dynamic value) {
  if (value == null) return null;
  
  try {
    if (value is DateTime) return value;
    if (value is String) return DateTime.parse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  } catch (e) {
    // Error parsing DateTime: $e
    return null;
  }
}

// Safe double conversion
double _safeDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}


