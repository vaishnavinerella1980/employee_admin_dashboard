
class AppConstants {
  static const String appName = 'Employee Time Tracking';
  static const String appVersion = '1.0.0';
  
  // Database constants
  static const String databaseName = 'employee_tracking.db';
  static const int databaseVersion = 1;
  
  // Shared Preferences keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserToken = 'user_token';
  static const String keySelectedTheme = 'selected_theme';
  
  // API constants
  static const int apiTimeoutSeconds = 30;
  static const int maxRetries = 3;
  
  // Time tracking constants
  static const int standardWorkHours = 8;
  static const int breakTimeMinutes = 60;
}