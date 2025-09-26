import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/routes.dart';
import 'presentation/theme/app_theme.dart';
import 'core/constants/strings.dart';

class EmployeeTimeTrackingApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Follows system theme
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      
      // Optional: Add app-wide loading and error handling
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    );
  }
}