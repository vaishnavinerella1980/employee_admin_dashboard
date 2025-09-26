import 'package:employee_admin_dashboard/presentation/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/app_constants.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({Key? key}) : super(key: key);

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  final List<MenuItem> menuItems = [
    MenuItem(
      child: Icons.dashboard,
      label: 'Dashboard',
      route: '/dashboard',
    ),
    MenuItem(
      child: Icons.access_time,
      label: 'Live Tracking',
      route: '/live-tracking',
    ),
    MenuItem(
      child: Icons.history,
      label: 'Past Tracking',
      route: '/past-tracking',
    ),
    MenuItem(
      child: Icons.people,
      label: 'Employees',
      route: '/employee-records',
    ),
    MenuItem(
      child: Icons.analytics,
      label: 'Reports',
      route: '/reports',
    ),
    MenuItem(
      child: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const Divider(height: 1),
          Expanded(
            child: _buildMenuItems(context),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.access_time_filled,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TimeTracker',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Admin Panel',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    // Get current route from GoRouter
    final currentRoute = GoRouterState.of(context).uri.path;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isSelected = _isRouteSelected(currentRoute, item.route);

        return MenuItemWidget(
          item: item,
          isSelected: isSelected,
          onTap: () {
            context.go(item.route);
          },
        );
      },
    );
  }

  // Helper method to check if route is selected
  bool _isRouteSelected(String currentRoute, String menuRoute) {
    if (currentRoute == menuRoute) {
      return true;
    }

    // Handle sub-routes (e.g., if we're on /employees/123, highlight /employees)
    if (currentRoute.startsWith(menuRoute) && menuRoute != '/') {
      return true;
    }

    return false;
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 16),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: AppColors.primary,
              ),
            ),
            title: const Text('Admin'),
            trailing: PopupMenuButton<String>(
              child: const Icon(Icons.more_vert),
              onSelected: (value) async {
                switch (value) {
                  case 'profile':
                    context.go('/profile');
                    break;
                  case 'logout':
                    await _handleLogout(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyUserToken);
    await prefs.setBool(AppConstants.keyIsLoggedIn, false);
    // Navigate to login screen
    context.go('/login');
  }
}
