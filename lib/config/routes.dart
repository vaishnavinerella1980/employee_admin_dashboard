import 'package:employee_admin_dashboard/presentation/screens/dashboard_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/employee_detail_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/employee_record_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/live_tracking_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/login_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/past_tracking_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/profile_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/reports_screen.dart';
import 'package:employee_admin_dashboard/presentation/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => DashboardScreen(),
      ),
      GoRoute(
        path: '/live-tracking',
        builder: (context, state) => LiveTrackingScreen(),
      ),
      GoRoute(
        path: '/past-tracking',
        builder: (context, state) => PastTrackingScreen(),
      ),
      GoRoute(
        path: '/employee-records',
        builder: (context, state) => EmployeeRecordsScreen(),
        routes: [
          GoRoute(
            path: ':employeeId',
            builder: (context, state) {
              final employeeId = state.pathParameters['employeeId']!;
              return EmployeeDetailScreen(employeeId: employeeId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => ReportsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      // Add authentication logic here
      // For now, allow all routes
      return null;
    },
  );
});
