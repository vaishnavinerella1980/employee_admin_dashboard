import 'package:employee_admin_dashboard/data/providers/dashboard_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveStatsHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);

    return dashboardState.when(
      loading: () => _buildLoadingStats(),
      error: (error, stack) => _buildErrorStats(),
      data: (data) => _buildStats(data),
    );
  }

  Widget _buildLoadingStats() {
    return Row(
      children: List.generate(
          4,
          (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: _buildStatCard(
                    'Loading...',
                    '--',
                    Icons.hourglass_empty,
                    Colors.grey,
                  ),
                ),
              )),
    );
  }

  Widget _buildErrorStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Unable to load statistics',
        style: TextStyle(color: Colors.red[700]),
      ),
    );
  }

  Widget _buildStats(DashboardData data) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Employees',
            '${data.totalEmployees}',
            Icons.people,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Currently Active',
            '${data.clockedInEmployees}',
            Icons.login,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'On Break',
            '${data.onBreakEmployees}',
            Icons.pause_circle,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Offline',
            '${data.totalEmployees - data.clockedInEmployees}',
            Icons.logout,
            Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData child, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(child, color: color, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
