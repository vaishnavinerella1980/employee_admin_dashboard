import 'package:employee_admin_dashboard/data/providers/dashboard_providers.dart' show DashboardData, dashboardProvider;
import 'package:employee_admin_dashboard/presentation/screens/sidebar_menu.dart';
import 'package:employee_admin_dashboard/presentation/widgets/activity_widget.dart';
import 'package:employee_admin_dashboard/presentation/widgets/loading_widgets.dart';
import 'package:employee_admin_dashboard/presentation/widgets/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';
import '../../../data/providers/employee_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load initial data with proper error handling
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // Load employees first
        await ref.read(employeeProvider.notifier).loadEmployees();

        // Then load dashboard data after employees are loaded
        await ref.read(dashboardProvider.notifier).loadDashboardData();
      } catch (e) {
        // Handle initialization errors gracefully
        debugPrint('Dashboard initialization error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(),
          Expanded(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _buildStatusBadge(),
          const SizedBox(width: 16),
          _buildNotificationButton(),
          const SizedBox(width: 16),
          _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Consumer(
      builder: (context, ref, child) {
        final dashboardState = ref.watch(dashboardProvider);
        return dashboardState.when(
          loading: () => const SizedBox.shrink(),
         error: (error, _) => Center(
  child: CustomErrorWidget(
    message: error.toString(),
    onRetry: () {
      ref.read(dashboardProvider.notifier).loadDashboardData();
    },
  ),
),

          data: (data) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Colors.green, size: 8),
                const SizedBox(width: 6),
                Text(
                  '${data.activeEmployees} Online',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      children: [
        GestureDetector(
          child: const Icon(Icons.notifications_outlined),
          onTap: () {
            // Handle notifications
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildContent() {
    return Consumer(
      builder: (context, ref, child) {
        final dashboardState = ref.watch(dashboardProvider);
        
        return dashboardState.when(
          loading: () => const Center(child: LoadingWidget()),
        error: (error, _) => Center(
  child: CustomErrorWidget(
    message: error.toString(),
    onRetry: () {
      ref.read(dashboardProvider.notifier).loadDashboardData();
    },
  ),
),

          data: (data) => _buildDashboardContent(data),
        );
      },
    );
  }

  Widget _buildDashboardContent(DashboardData data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGrid(data),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ActivityFeed(activities: data.recentActivities),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: QuickActions(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(DashboardData data) {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'Total Employees',
            value: '${data.totalEmployees}',
            icon: Icons.people,
            color: Colors.blue,
            trend: data.employeeTrend,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'Clocked In',
            value: '${data.clockedInEmployees}',
            icon: Icons.login,
            color: Colors.green,
            trend: data.clockedInTrend,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'On Break',
            value: '${data.onBreakEmployees}',
            icon: Icons.pause_circle,
            color: Colors.orange,
            trend: data.breakTrend,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'Overtime',
            value: '${data.overtimeEmployees}',
            icon: Icons.access_time,
            color: Colors.red,
            trend: data.overtimeTrend,
          ),
        ),
      ],
    );
  }
}