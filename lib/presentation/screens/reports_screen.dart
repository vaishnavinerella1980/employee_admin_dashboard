import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/reports_provider.dart';
import '../../../data/providers/attendance_provider.dart';
import '../../../data/models/report.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  String selectedPeriod = 'This Month';
  String selectedReport = 'Attendance Summary';
  DateTime? fromDate;
  DateTime? toDate;

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
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reports & Analytics',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Generate and view attendance reports',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _generateReport,
            icon: const Icon(Icons.file_download),
            label: const Text('Generate Report'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedReport,
                  decoration: InputDecoration(
                    labelText: 'Report Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  items: [
                    'Attendance Summary',
                    'Time Tracking Report',
                    'Department Analysis',
                    'Overtime Report',
                    'Employee Performance',
                  ]
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedReport = value!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedPeriod,
                  decoration: InputDecoration(
                    labelText: 'Time Period',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  items: [
                    'Today',
                    'This Week',
                    'This Month',
                    'Last Month',
                    'This Quarter',
                    'This Year',
                    'Custom Range',
                  ]
                      .map((period) =>
                          DropdownMenuItem(value: period, child: Text(period)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPeriod = value!;
                      if (value != 'Custom Range') {
                        // Clear custom dates when switching to predefined periods
                        fromDate = null;
                        toDate = null;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                label: const Text('More Filters'),
              ),
            ],
          ),
          // Show custom date range selectors when "Custom Range" is selected
          if (selectedPeriod == 'Custom Range') ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateSelector(
                    label: 'From Date',
                    selectedDate: fromDate,
                    onDateSelected: (date) => setState(() => fromDate = date),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateSelector(
                    label: 'To Date',
                    selectedDate: toDate,
                    onDateSelected: (date) => setState(() => toDate = date),
                    firstDate: fromDate, // To date should be after from date
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateSelector({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
    DateTime? firstDate,
  }) {
    return InkWell(
      onTap: () => _selectDate(
        context: context,
        selectedDate: selectedDate,
        onDateSelected: onDateSelected,
        firstDate: firstDate,
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate != null ? _formatDate(selectedDate) : 'Select $label',
          style: TextStyle(
            color: selectedDate != null
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate({
    required BuildContext context,
    DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
    DateTime? firstDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).primaryColor,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickStats(),
          const SizedBox(height: 24),
          _buildReportPreview(),
          const SizedBox(height: 24),
          _buildRecentReports(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final attendanceState = ref.watch(attendanceProvider);
    final attendanceRecords = attendanceState.records;

    // Calculate real statistics
    final totalHours = attendanceRecords
        .where((r) => r.workDuration != null)
        .fold<Duration>(Duration.zero, (sum, r) => sum + (r.workDuration ?? Duration.zero));

    final activeRecords = attendanceRecords.where((r) => r.isActive).length;
    final completedRecords = attendanceRecords.where((r) => !r.isActive).length;
    final totalRecords = attendanceRecords.length;

    final avgDailyHours = totalRecords > 0 ? totalHours.inHours / totalRecords : 0;
    final overtimeHours = attendanceRecords
        .where((r) => r.workDuration != null && r.workDuration!.inHours > 8)
        .fold<Duration>(Duration.zero, (sum, r) => sum + ((r.workDuration ?? Duration.zero) - const Duration(hours: 8)));

    final attendanceRate = totalRecords > 0 ? (completedRecords / totalRecords) * 100 : 0;

    return Row(
      children: [
        Expanded(
            child: _buildStatCard(
                'Total Hours', '${totalHours.inHours}h', Icons.access_time, Colors.blue)),
        const SizedBox(width: 16),
        Expanded(
            child: _buildStatCard(
                'Avg Daily Hours', '${avgDailyHours.toStringAsFixed(1)}h', Icons.today, Colors.green)),
        const SizedBox(width: 16),
        Expanded(
            child: _buildStatCard(
                'Overtime Hours', '${overtimeHours.inHours}h', Icons.schedule, Colors.orange)),
        const SizedBox(width: 16),
        Expanded(
            child: _buildStatCard(
                'Attendance Rate', '${attendanceRate.toStringAsFixed(1)}%', Icons.check_circle, Colors.purple)),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
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
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportPreview() {
    String reportTitle = selectedPeriod == 'Custom Range' &&
            fromDate != null &&
            toDate != null
        ? '$selectedReport - ${_formatDate(fromDate!)} to ${_formatDate(toDate!)}'
        : '$selectedReport - $selectedPeriod';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  reportTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.fullscreen),
                label: const Text('Full View'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Show validation message for custom range
          if (selectedPeriod == 'Custom Range' &&
              (fromDate == null || toDate == null))
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Please select both From and To dates for custom range',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Placeholder for chart/graph
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Report Chart Preview',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Interactive charts will be displayed here',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReports() {
    final reportsState = ref.watch(reportsProvider);
    final recentReports = ref.watch(recentReportsProvider);

    if (reportsState.isLoading) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (reportsState.error != null) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
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
            Text(
              'Recent Reports',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load reports',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reportsState.error!,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.read(reportsProvider.notifier).loadReports(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (recentReports.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
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
            Text(
              'Recent Reports',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Icon(Icons.description_outlined, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No reports generated yet',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Generate your first report to see it here',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Reports',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: () => ref.read(reportsProvider.notifier).loadReports(),
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...recentReports.map((report) => ListTile(
                leading: const Icon(Icons.description),
                title: Text(report.name),
                subtitle: Text(
                  'Generated on ${_formatDate(report.generatedAt)} • ${_formatFileSize(report.fileSize)}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () => _downloadReport(report.id),
                      tooltip: 'Download Report',
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () => _shareReport(report.id),
                      tooltip: 'Share Report',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteReport(report.id),
                      tooltip: 'Delete Report',
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _generateReport() async {
    // Validate custom range if selected
    if (selectedPeriod == 'Custom Range' &&
        (fromDate == null || toDate == null)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Date Range'),
          content: const Text(
              'Please select both From and To dates for custom range.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Validate that from date is before to date
    if (selectedPeriod == 'Custom Range' &&
        fromDate != null &&
        toDate != null &&
        fromDate!.isAfter(toDate!)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Date Range'),
          content: const Text('From date must be before To date.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Map selected report type to provider report type
    String reportType = _mapReportType(selectedReport);

    try {
      await ref.read(reportsProvider.notifier).generateReport(
        reportType: reportType,
        period: selectedPeriod,
        fromDate: fromDate,
        toDate: toDate,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate report: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _mapReportType(String selectedReport) {
    switch (selectedReport) {
      case 'Attendance Summary':
        return 'attendanceSummary';
      case 'Time Tracking Report':
        return 'timeTracking';
      case 'Department Analysis':
        return 'departmentAnalysis';
      case 'Overtime Report':
        return 'overtimeReport';
      case 'Employee Performance':
        return 'employeePerformance';
      default:
        return 'attendanceSummary';
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  Future<void> _downloadReport(String reportId) async {
    ref.read(reportsProvider.notifier).downloadReport(reportId);

    // Show success message immediately (since the provider handles errors internally)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report download initiated!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> _shareReport(String reportId) async {
    ref.read(reportsProvider.notifier).shareReport(reportId);

    // Show success message immediately (since the provider handles errors internally)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report share initiated!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> _deleteReport(String reportId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Report'),
        content: const Text('Are you sure you want to delete this report? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      ref.read(reportsProvider.notifier).deleteReport(reportId);

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report deletion initiated!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }
}
