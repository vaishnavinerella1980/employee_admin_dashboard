import 'package:employee_admin_dashboard/presentation/screens/employee_tracking_card.dart';
import 'package:employee_admin_dashboard/presentation/widgets/live_stats_header.dart';
import 'package:employee_admin_dashboard/presentation/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/providers/employee_provider.dart';

class LiveTrackingScreen extends ConsumerStatefulWidget {
  const LiveTrackingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  String searchQuery = '';
  String selectedDepartment = 'All';
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(employeeProvider.notifier).loadEmployees();
    });
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }

  Set<Marker> _buildMarkers(List<dynamic> employees) {
    // EmployeeEntity doesn't include coordinates. Until we have a source of lat/lng,
    // return an empty marker set to avoid build errors.
    return <Marker>{};
  }

  // Default location for map initialization (fallback)
  static const LatLng _defaultLocation =
      LatLng(40.7128, -74.0060); // New York City

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Live Employee Tracking',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, color: Colors.green, size: 8),
                    const SizedBox(width: 6),
                    Text(
                      'Live Updates',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LiveStatsHeader(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search employees...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedDepartment,
              decoration: InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              items: [
                'All',
                'Engineering',
                'Marketing',
                'Sales',
                'HR',
                'ITinfrastructure',
                'Finance',
                'Installation',
                'Software',
                'Support'
              ]
                  .map((dept) => DropdownMenuItem(
                        value: dept,
                        child: Text(dept),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDepartment = value ?? 'All';
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(employeeProvider.notifier).loadEmployees();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final employeeState = ref.watch(employeeProvider);

    return employeeState.when(
      initial: () => const Center(child: LoadingWidget()),
      loading: () => const Center(child: LoadingWidget()),
      error: (error) => Center(
        child: CustomErrorWidget(
          message: error,
          onRetry: () => ref.read(employeeProvider.notifier).loadEmployees(),
        ),
      ),
      loaded: (employees) {
        final filteredEmployees = employees.where((employee) {
          final name = (employee.name ?? '').toString().toLowerCase();
          final dept = (employee.department ?? '').toString().toLowerCase();
          final q = searchQuery.toLowerCase();

          final matchesSearch =
              searchQuery.isEmpty || name.contains(q) || dept.contains(q);

          final matchesDepartment = selectedDepartment == 'All' ||
              employee.department == selectedDepartment;

          return matchesSearch && matchesDepartment;
        }).toList();

        if (filteredEmployees.isEmpty) return _buildEmptyState();

        final markers = _buildMarkers(filteredEmployees);

        // determine camera target (first employee)
        // EmployeeEntity has no lat/lng; use a safe default location
        final initialCamera = const CameraPosition(
          target: _defaultLocation,
          zoom: 10, // reasonable zoom level for city view
        );

        return Column(
          children: [
            // Map
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                      // No coordinates available on EmployeeEntity; keep default view
                    },
                    initialCameraPosition: initialCamera,
                    markers: markers,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    onTap: (position) {
                      // Handle map tap if needed
                    },
                  ),
                ),
              ),
            ),

            // Grid of employees
            Expanded(
              flex: 3,
              child: _buildEmployeeGrid(filteredEmployees),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No employees found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeGrid(List<dynamic> employees) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return EmployeeTrackingCard(employee: employees[index]);
        },
      ),
    );
  }
}
