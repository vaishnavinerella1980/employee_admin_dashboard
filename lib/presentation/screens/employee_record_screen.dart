import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/employee_entity.dart';
import '../../data/providers/employee_provider.dart';

// Date Time Utility Class
class DateTimeUtils {
  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

// Employee Records Screen using Riverpod
class EmployeeRecordsScreen extends ConsumerStatefulWidget {
  const EmployeeRecordsScreen({super.key});

  @override
  ConsumerState<EmployeeRecordsScreen> createState() =>
      _EmployeeRecordsScreenState();
}

class _EmployeeRecordsScreenState extends ConsumerState<EmployeeRecordsScreen> {
  String searchQuery = '';
  String selectedDepartment = 'All';
  String sortBy = 'name';
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    // Load employees when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(employeeProvider.notifier).loadEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    final employeeState = ref.watch(employeeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Records'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSearchAndFilters(),
            const SizedBox(height: 20),
            _buildContent(employeeState),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Employee Records',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ElevatedButton.icon(
          onPressed: _showAddEmployeeDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add Employee'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search employees...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2E7D32)),
              ),
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
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: [
              'All',
              'Engineering',
              'Marketing',
              'Sales',
              'Human Resources',
              'Finance',
              'IT infrastructure',
              'Software Development',
              'Installation',
              'Customer Support'
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
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.read(employeeProvider.notifier).loadEmployees(),
        ),
      ],
    );
  }

  Widget _buildContent(EmployeeState employeeState) {
    return employeeState.when(
      initial: () => const Expanded(
        child: Center(child: Text('Ready to load employees')),
      ),
      loading: () => const Expanded(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (message) => Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error: $message',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(employeeProvider.notifier).loadEmployees(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      loaded: (employees) {
        final filteredEmployees = _filterAndSortEmployees(employees);
        return Expanded(child: _buildEmployeeTable(filteredEmployees));
      },
    );
  }

  List<EmployeeEntity> _filterAndSortEmployees(List<EmployeeEntity> employees) {
    List<EmployeeEntity> filtered = employees.where((employee) {
      final matchesSearch = searchQuery.isEmpty ||
          employee.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          employee.email.toLowerCase().contains(searchQuery.toLowerCase()) ||
          employee.position.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesDepartment = selectedDepartment == 'All' ||
          employee.department == selectedDepartment;

      return matchesSearch && matchesDepartment;
    }).toList();

    filtered.sort((a, b) {
      int comparison;
      switch (sortBy) {
        case 'name':
          comparison = a.name.compareTo(b.name);
          break;
        case 'department':
          comparison = a.department.compareTo(b.department);
          break;
        case 'position':
          comparison = a.position.compareTo(b.position);
          break;
        default:
          comparison = a.name.compareTo(b.name);
      }
      return isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  Widget _buildEmployeeTable(List<EmployeeEntity> filteredEmployees) {
    if (filteredEmployees.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No employees found',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Department')),
            DataColumn(label: Text('Position')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Clock Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: filteredEmployees.map(_buildEmployeeRow).toList(),
        ),
      ),
    );
  }

  DataRow _buildEmployeeRow(EmployeeEntity employee) {
    return DataRow(
      cells: [
        DataCell(_buildEmployeeName(employee)),
        DataCell(Text(employee.email)),
        DataCell(_buildDepartmentChip(employee.department)),
        DataCell(Text(employee.position)),
        DataCell(_buildStatusChip(employee)),
        DataCell(_buildClockStatusChip(employee)),
        DataCell(_buildActionButtons(employee)),
      ],
    );
  }

  Widget _buildEmployeeName(EmployeeEntity employee) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: const Color(0xFF2E7D32),
          child: Text(
            employee.name.isNotEmpty ? employee.name[0].toUpperCase() : '?',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(employee.name,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('ID: ${employee.id}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartmentChip(String department) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getDepartmentColor(department),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        department,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildStatusChip(EmployeeEntity employee) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: employee.isActive ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        employee.isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: employee.isActive ? Colors.green[700] : Colors.red[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildClockStatusChip(EmployeeEntity employee) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: employee.isClockedIn ? Colors.blue[100] : Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        employee.isClockedIn ? 'Clocked In' : 'Clocked Out',
        style: TextStyle(
          color: employee.isClockedIn ? Colors.blue[700] : Colors.orange[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButtons(EmployeeEntity employee) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 18),
          onPressed: () => _showEditEmployeeDialog(employee),
        ),
        IconButton(
          icon: const Icon(Icons.visibility, size: 18),
          onPressed: () => _showViewEmployeeDialog(employee),
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 18, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(employee),
        ),
      ],
    );
  }

  Color _getDepartmentColor(String department) {
    switch (department.toLowerCase()) {
      case 'engineering':
        return Colors.blue;
      case 'marketing':
        return Colors.purple;
      case 'sales':
        return Colors.green;
      case 'human resources':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Employee'),
        content:
            const Text('Add employee functionality will be implemented here.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Add')),
        ],
      ),
    );
  }

  void _showEditEmployeeDialog(EmployeeEntity employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${employee.name}'),
        content:
            const Text('Edit employee functionality will be implemented here.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Save')),
        ],
      ),
    );
  }

  void _showViewEmployeeDialog(EmployeeEntity employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(employee.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${employee.id}'),
            Text('Email: ${employee.email}'),
            Text('Department: ${employee.department}'),
            Text('Position: ${employee.position}'),
            Text('Status: ${employee.isActive ? 'Active' : 'Inactive'}'),
            Text(
                'Clock Status: ${employee.isClockedIn ? 'Clocked In' : 'Clocked Out'}'),
            if (employee.lastClockIn != null)
              Text(
                  'Last Clock In: ${DateTimeUtils.formatTime(employee.lastClockIn!)}'),
            if (employee.lastClockOut != null)
              Text(
                  'Last Clock Out: ${DateTimeUtils.formatTime(employee.lastClockOut!)}'),
            if (employee.hireDate != null)
              Text('Hire Date: ${employee.hireDate!.toString().split(' ')[0]}'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(EmployeeEntity employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete ${employee.name}?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement delete functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${employee.name} has been deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
