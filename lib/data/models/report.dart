class Report {
  final String id;
  final String name;
  final String type;
  final DateTime generatedAt;
  final String generatedBy;
  final Map<String, dynamic> parameters;
  final String filePath;
  final int fileSize;
  final String? description;
  final DateTime? expiresAt;

  Report({
    required this.id,
    required this.name,
    required this.type,
    required this.generatedAt,
    required this.generatedBy,
    required this.parameters,
    required this.filePath,
    required this.fileSize,
    this.description,
    this.expiresAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      generatedAt: DateTime.parse(json['generatedAt'] ?? DateTime.now().toIso8601String()),
      generatedBy: json['generatedBy'] ?? 'System',
      parameters: Map<String, dynamic>.from(json['parameters'] ?? {}),
      filePath: json['filePath'] ?? '',
      fileSize: json['fileSize'] ?? 0,
      description: json['description'],
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'generatedAt': generatedAt.toIso8601String(),
      'generatedBy': generatedBy,
      'parameters': parameters,
      'filePath': filePath,
      'fileSize': fileSize,
      'description': description,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  Report copyWith({
    String? id,
    String? name,
    String? type,
    DateTime? generatedAt,
    String? generatedBy,
    Map<String, dynamic>? parameters,
    String? filePath,
    int? fileSize,
    String? description,
    DateTime? expiresAt,
  }) {
    return Report(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      generatedAt: generatedAt ?? this.generatedAt,
      generatedBy: generatedBy ?? this.generatedBy,
      parameters: parameters ?? this.parameters,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      description: description ?? this.description,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

enum ReportType {
  attendanceSummary,
  timeTracking,
  departmentAnalysis,
  overtimeReport,
  employeePerformance,
}

extension ReportTypeExtension on ReportType {
  String get displayName {
    switch (this) {
      case ReportType.attendanceSummary:
        return 'Attendance Summary';
      case ReportType.timeTracking:
        return 'Time Tracking Report';
      case ReportType.departmentAnalysis:
        return 'Department Analysis';
      case ReportType.overtimeReport:
        return 'Overtime Report';
      case ReportType.employeePerformance:
        return 'Employee Performance';
    }
  }

  String get value => toString().split('.').last;
}
