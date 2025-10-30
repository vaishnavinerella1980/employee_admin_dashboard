import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../data/local/local_database.dart';
import 'local_database_provider.dart';

// ========================================
// SETTINGS STATE
// ========================================

class SettingsState {
  final bool notificationsEnabled;
  final bool emailReports;
  final String selectedTheme;
  final String workingHoursStart;
  final String workingHoursEnd;
  final bool locationTracking;
  final bool isLoading;
  final String? error;

  // Company Information
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final String companyEmail;

  // Language & Region
  final String language;
  final String region;

  // Time Zone
  final String timeZone;

  // Break Settings
  final int breakDurationMinutes;
  final bool autoBreakEnabled;

  // Attendance Rules
  final int lateThresholdMinutes;
  final int overtimeThresholdHours;
  final bool strictAttendance;

  // Clock-in Reminders
  final bool clockInRemindersEnabled;
  final int reminderIntervalMinutes;

  // Color Scheme
  final String primaryColor;
  final String accentColor;

  // Dashboard Layout
  final List<String> dashboardWidgets;
  final int dashboardColumns;

  // Backup & Sync
  final bool autoBackupEnabled;
  final int backupFrequencyDays;
  final bool cloudSyncEnabled;

  // Security
  final bool biometricEnabled;
  final int sessionTimeoutMinutes;
  final bool twoFactorEnabled;

  // Software Updates
  final bool autoUpdateEnabled;
  final String updateChannel;

  SettingsState({
    required this.notificationsEnabled,
    required this.emailReports,
    required this.selectedTheme,
    required this.workingHoursStart,
    required this.workingHoursEnd,
    required this.locationTracking,
    this.isLoading = false,
    this.error,
    this.companyName = 'Your Company',
    this.companyAddress = '',
    this.companyPhone = '',
    this.companyEmail = '',
    this.language = 'English',
    this.region = 'US',
    this.timeZone = 'UTC-5',
    this.breakDurationMinutes = 30,
    this.autoBreakEnabled = false,
    this.lateThresholdMinutes = 15,
    this.overtimeThresholdHours = 8,
    this.strictAttendance = false,
    this.clockInRemindersEnabled = true,
    this.reminderIntervalMinutes = 60,
    this.primaryColor = '#2E7D32',
    this.accentColor = '#4CAF50',
    this.dashboardWidgets = const ['stats', 'recent_activity', 'quick_actions'],
    this.dashboardColumns = 2,
    this.autoBackupEnabled = true,
    this.backupFrequencyDays = 7,
    this.cloudSyncEnabled = false,
    this.biometricEnabled = false,
    this.sessionTimeoutMinutes = 30,
    this.twoFactorEnabled = false,
    this.autoUpdateEnabled = true,
    this.updateChannel = 'stable',
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? emailReports,
    String? selectedTheme,
    String? workingHoursStart,
    String? workingHoursEnd,
    bool? locationTracking,
    bool? isLoading,
    String? error,
    String? companyName,
    String? companyAddress,
    String? companyPhone,
    String? companyEmail,
    String? language,
    String? region,
    String? timeZone,
    int? breakDurationMinutes,
    bool? autoBreakEnabled,
    int? lateThresholdMinutes,
    int? overtimeThresholdHours,
    bool? strictAttendance,
    bool? clockInRemindersEnabled,
    int? reminderIntervalMinutes,
    String? primaryColor,
    String? accentColor,
    List<String>? dashboardWidgets,
    int? dashboardColumns,
    bool? autoBackupEnabled,
    int? backupFrequencyDays,
    bool? cloudSyncEnabled,
    bool? biometricEnabled,
    int? sessionTimeoutMinutes,
    bool? twoFactorEnabled,
    bool? autoUpdateEnabled,
    String? updateChannel,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailReports: emailReports ?? this.emailReports,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      workingHoursStart: workingHoursStart ?? this.workingHoursStart,
      workingHoursEnd: workingHoursEnd ?? this.workingHoursEnd,
      locationTracking: locationTracking ?? this.locationTracking,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
      language: language ?? this.language,
      region: region ?? this.region,
      timeZone: timeZone ?? this.timeZone,
      breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
      autoBreakEnabled: autoBreakEnabled ?? this.autoBreakEnabled,
      lateThresholdMinutes: lateThresholdMinutes ?? this.lateThresholdMinutes,
      overtimeThresholdHours:
          overtimeThresholdHours ?? this.overtimeThresholdHours,
      strictAttendance: strictAttendance ?? this.strictAttendance,
      clockInRemindersEnabled:
          clockInRemindersEnabled ?? this.clockInRemindersEnabled,
      reminderIntervalMinutes:
          reminderIntervalMinutes ?? this.reminderIntervalMinutes,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      dashboardWidgets: dashboardWidgets ?? this.dashboardWidgets,
      dashboardColumns: dashboardColumns ?? this.dashboardColumns,
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      backupFrequencyDays: backupFrequencyDays ?? this.backupFrequencyDays,
      cloudSyncEnabled: cloudSyncEnabled ?? this.cloudSyncEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      sessionTimeoutMinutes:
          sessionTimeoutMinutes ?? this.sessionTimeoutMinutes,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      autoUpdateEnabled: autoUpdateEnabled ?? this.autoUpdateEnabled,
      updateChannel: updateChannel ?? this.updateChannel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'emailReports': emailReports,
      'selectedTheme': selectedTheme,
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'locationTracking': locationTracking,
      'companyName': companyName,
      'companyAddress': companyAddress,
      'companyPhone': companyPhone,
      'companyEmail': companyEmail,
      'language': language,
      'region': region,
      'timeZone': timeZone,
      'breakDurationMinutes': breakDurationMinutes,
      'autoBreakEnabled': autoBreakEnabled,
      'lateThresholdMinutes': lateThresholdMinutes,
      'overtimeThresholdHours': overtimeThresholdHours,
      'strictAttendance': strictAttendance,
      'clockInRemindersEnabled': clockInRemindersEnabled,
      'reminderIntervalMinutes': reminderIntervalMinutes,
      'primaryColor': primaryColor,
      'accentColor': accentColor,
      'dashboardWidgets': dashboardWidgets,
      'dashboardColumns': dashboardColumns,
      'autoBackupEnabled': autoBackupEnabled,
      'backupFrequencyDays': backupFrequencyDays,
      'cloudSyncEnabled': cloudSyncEnabled,
      'biometricEnabled': biometricEnabled,
      'sessionTimeoutMinutes': sessionTimeoutMinutes,
      'twoFactorEnabled': twoFactorEnabled,
      'autoUpdateEnabled': autoUpdateEnabled,
      'updateChannel': updateChannel,
    };
  }

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      emailReports: json['emailReports'] ?? false,
      selectedTheme: json['selectedTheme'] ?? 'System',
      workingHoursStart: json['workingHoursStart'] ?? '09:00',
      workingHoursEnd: json['workingHoursEnd'] ?? '17:00',
      locationTracking: json['locationTracking'] ?? true,
      companyName: json['companyName'] ?? 'Your Company',
      companyAddress: json['companyAddress'] ?? '',
      companyPhone: json['companyPhone'] ?? '',
      companyEmail: json['companyEmail'] ?? '',
      language: json['language'] ?? 'English',
      region: json['region'] ?? 'US',
      timeZone: json['timeZone'] ?? 'UTC-5',
      breakDurationMinutes: json['breakDurationMinutes'] ?? 30,
      autoBreakEnabled: json['autoBreakEnabled'] ?? false,
      lateThresholdMinutes: json['lateThresholdMinutes'] ?? 15,
      overtimeThresholdHours: json['overtimeThresholdHours'] ?? 8,
      strictAttendance: json['strictAttendance'] ?? false,
      clockInRemindersEnabled: json['clockInRemindersEnabled'] ?? true,
      reminderIntervalMinutes: json['reminderIntervalMinutes'] ?? 60,
      primaryColor: json['primaryColor'] ?? '#2E7D32',
      accentColor: json['accentColor'] ?? '#4CAF50',
      dashboardWidgets: List<String>.from(json['dashboardWidgets'] ??
          ['stats', 'recent_activity', 'quick_actions']),
      dashboardColumns: json['dashboardColumns'] ?? 2,
      autoBackupEnabled: json['autoBackupEnabled'] ?? true,
      backupFrequencyDays: json['backupFrequencyDays'] ?? 7,
      cloudSyncEnabled: json['cloudSyncEnabled'] ?? false,
      biometricEnabled: json['biometricEnabled'] ?? false,
      sessionTimeoutMinutes: json['sessionTimeoutMinutes'] ?? 30,
      twoFactorEnabled: json['twoFactorEnabled'] ?? false,
      autoUpdateEnabled: json['autoUpdateEnabled'] ?? true,
      updateChannel: json['updateChannel'] ?? 'stable',
    );
  }
}

// ========================================
// SETTINGS NOTIFIER
// ========================================

class SettingsNotifier extends Notifier<SettingsState> {
  late LocalDatabase _database;

  @override
  SettingsState build() {
    _database = ref.watch(localDatabaseProvider);
    _loadSettings();
    return SettingsState(
      notificationsEnabled: true,
      emailReports: false,
      selectedTheme: 'System',
      workingHoursStart: '09:00',
      workingHoursEnd: '17:00',
      locationTracking: true,
    );
  }

  Future<void> _loadSettings() async {
    try {
      final settingsData = _database.getSetting('app_settings');
      if (settingsData != null) {
        final settings = SettingsState.fromJson(settingsData);
        state = settings;
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> updateNotificationsEnabled(bool value) async {
    state = state.copyWith(notificationsEnabled: value);
    await _saveSettings();
  }

  Future<void> updateEmailReports(bool value) async {
    state = state.copyWith(emailReports: value);
    await _saveSettings();
  }

  Future<void> updateTheme(String theme) async {
    state = state.copyWith(selectedTheme: theme);
    await _saveSettings();
  }

  Future<void> updateWorkingHours(String start, String end) async {
    state = state.copyWith(
      workingHoursStart: start,
      workingHoursEnd: end,
    );
    await _saveSettings();
  }

  Future<void> updateLocationTracking(bool value) async {
    state = state.copyWith(locationTracking: value);
    await _saveSettings();
  }

  // Company Information
  Future<void> updateCompanyInfo({
    String? name,
    String? address,
    String? phone,
    String? email,
  }) async {
    state = state.copyWith(
      companyName: name ?? state.companyName,
      companyAddress: address ?? state.companyAddress,
      companyPhone: phone ?? state.companyPhone,
      companyEmail: email ?? state.companyEmail,
    );
    await _saveSettings();
  }

  // Language & Region
  Future<void> updateLanguageAndRegion(String language, String region) async {
    state = state.copyWith(language: language, region: region);
    await _saveSettings();
  }

  // Time Zone
  Future<void> updateTimeZone(String timeZone) async {
    state = state.copyWith(timeZone: timeZone);
    await _saveSettings();
  }

  // Break Settings
  Future<void> updateBreakSettings(int durationMinutes, bool autoBreak) async {
    state = state.copyWith(
      breakDurationMinutes: durationMinutes,
      autoBreakEnabled: autoBreak,
    );
    await _saveSettings();
  }

  // Attendance Rules
  Future<void> updateAttendanceRules({
    int? lateThreshold,
    int? overtimeThreshold,
    bool? strictAttendance,
  }) async {
    state = state.copyWith(
      lateThresholdMinutes: lateThreshold ?? state.lateThresholdMinutes,
      overtimeThresholdHours: overtimeThreshold ?? state.overtimeThresholdHours,
      strictAttendance: strictAttendance ?? state.strictAttendance,
    );
    await _saveSettings();
  }

  // Clock-in Reminders
  Future<void> updateClockInReminders(bool enabled, int intervalMinutes) async {
    state = state.copyWith(
      clockInRemindersEnabled: enabled,
      reminderIntervalMinutes: intervalMinutes,
    );
    await _saveSettings();
  }

  // Color Scheme
  Future<void> updateColorScheme(
      String primaryColor, String accentColor) async {
    state = state.copyWith(
      primaryColor: primaryColor,
      accentColor: accentColor,
    );
    await _saveSettings();
  }

  // Dashboard Layout
  Future<void> updateDashboardLayout(List<String> widgets, int columns) async {
    state = state.copyWith(
      dashboardWidgets: widgets,
      dashboardColumns: columns,
    );
    await _saveSettings();
  }

  // Backup & Sync
  Future<void> updateBackupSettings(
      bool autoBackup, int frequencyDays, bool cloudSync) async {
    state = state.copyWith(
      autoBackupEnabled: autoBackup,
      backupFrequencyDays: frequencyDays,
      cloudSyncEnabled: cloudSync,
    );
    await _saveSettings();
  }

  // Security
  Future<void> updateSecuritySettings({
    bool? biometric,
    int? sessionTimeout,
    bool? twoFactor,
  }) async {
    state = state.copyWith(
      biometricEnabled: biometric ?? state.biometricEnabled,
      sessionTimeoutMinutes: sessionTimeout ?? state.sessionTimeoutMinutes,
      twoFactorEnabled: twoFactor ?? state.twoFactorEnabled,
    );
    await _saveSettings();
  }

  // Software Updates
  Future<void> updateSoftwareUpdates(bool autoUpdate, String channel) async {
    state = state.copyWith(
      autoUpdateEnabled: autoUpdate,
      updateChannel: channel,
    );
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    try {
      await _database.saveSetting('app_settings', state.toJson());
    } catch (e) {
      debugPrint('Error saving settings: $e');
      state = state.copyWith(error: 'Failed to save settings');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// ========================================
// PROVIDERS
// ========================================

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  () => SettingsNotifier(),
);

// Computed providers for specific settings
final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).notificationsEnabled;
});

final emailReportsProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).emailReports;
});

final selectedThemeProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).selectedTheme;
});

final workingHoursProvider = Provider<Map<String, String>>((ref) {
  final settings = ref.watch(settingsProvider);
  return {
    'start': settings.workingHoursStart,
    'end': settings.workingHoursEnd,
  };
});

final locationTrackingProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).locationTracking;
});
