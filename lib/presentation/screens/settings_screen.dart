import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
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
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _saveSettings,
            icon: const Icon(Icons.save),
            label: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralSettings(),
          const SizedBox(height: 24),
          _buildTimeTrackingSettings(),
          const SizedBox(height: 24),
          _buildNotificationSettings(),
          const SizedBox(height: 24),
          _buildAppearanceSettings(),
          const SizedBox(height: 24),
          _buildSystemSettings(),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    final settings = ref.watch(settingsProvider);

    return _buildSettingsSection(
      'General Settings',
      [
        ListTile(
          leading: const Icon(Icons.business),
          title: const Text('Company Information'),
          subtitle: Text(settings.companyName),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showCompanyInfoDialog,
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language & Region'),
          subtitle: Text('${settings.language} (${settings.region})'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showLanguageRegionDialog,
        ),
        ListTile(
          leading: const Icon(Icons.access_time),
          title: const Text('Time Zone'),
          subtitle: Text(settings.timeZone),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showTimeZoneDialog,
        ),
      ],
    );
  }

  Widget _buildTimeTrackingSettings() {
    final settings = ref.watch(settingsProvider);

    return _buildSettingsSection(
      'Time Tracking',
      [
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text('Working Hours'),
          subtitle: Text(
              '${settings.workingHoursStart} - ${settings.workingHoursEnd}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showWorkingHoursDialog,
        ),
        ListTile(
          leading: const Icon(Icons.access_alarm),
          title: const Text('Break Settings'),
          subtitle: const Text('Configure break time policies'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Location Tracking'),
          subtitle: const Text('GPS-based time tracking'),
          trailing: Switch(
            value: settings.locationTracking,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).updateLocationTracking(value);
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.rule),
          title: const Text('Attendance Rules'),
          subtitle: const Text('Late arrival and overtime policies'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    final settings = ref.watch(settingsProvider);

    return _buildSettingsSection(
      'Notifications',
      [
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive app notifications'),
          trailing: Switch(
            value: settings.notificationsEnabled,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .updateNotificationsEnabled(value);
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email Reports'),
          subtitle: const Text('Receive daily/weekly reports via email'),
          trailing: Switch(
            value: settings.emailReports,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).updateEmailReports(value);
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.alarm),
          title: const Text('Clock-in Reminders'),
          subtitle: const Text('Remind employees to clock in'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAppearanceSettings() {
    final settings = ref.watch(settingsProvider);

    return _buildSettingsSection(
      'Appearance',
      [
        ListTile(
          leading: const Icon(Icons.palette),
          title: const Text('Theme'),
          subtitle: Text(settings.selectedTheme),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showThemeDialog,
        ),
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: const Text('Color Scheme'),
          subtitle: const Text('Customize app colors'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Dashboard Layout'),
          subtitle: const Text('Customize dashboard widgets'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSystemSettings() {
    return _buildSettingsSection(
      'System',
      [
        ListTile(
          leading: const Icon(Icons.backup),
          title: const Text('Backup & Sync'),
          subtitle: const Text('Automatic data backup'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text('Security'),
          subtitle: const Text('Authentication and access control'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.update),
          title: const Text('Software Updates'),
          subtitle: const Text('Check for updates'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          subtitle: const Text('Version 1.0.0'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showAboutDialog,
        ),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
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
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  void _showWorkingHoursDialog() {
    final settings = ref.watch(settingsProvider);
    String startTime = settings.workingHoursStart;
    String endTime = settings.workingHoursEnd;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Working Hours'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(startTime),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(startTime.split(':')[0]),
                    minute: int.parse(startTime.split(':')[1]),
                  ),
                );
                if (picked != null) {
                  startTime =
                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                  setState(() {});
                }
              },
            ),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text(endTime),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(endTime.split(':')[0]),
                    minute: int.parse(endTime.split(':')[1]),
                  ),
                );
                if (picked != null) {
                  endTime =
                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                  setState(() {});
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(settingsProvider.notifier)
                  .updateWorkingHours(startTime, endTime);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog() {
    final settings = ref.watch(settingsProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['System', 'Light', 'Dark']
              .map((theme) => RadioListTile<String>(
                    title: Text(theme),
                    value: theme,
                    groupValue: settings.selectedTheme,
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(settingsProvider.notifier).updateTheme(value);
                        Navigator.pop(context);
                      }
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Time Tracker'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee Time Tracking Admin Dashboard'),
            SizedBox(height: 8),
            Text('Version: 1.0.0'),
            Text('Build: 2024.01.15'),
            SizedBox(height: 16),
            Text('Â© 2024 Your Company Name'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCompanyInfoDialog() {
    final settings = ref.watch(settingsProvider);
    final nameController = TextEditingController(text: settings.companyName);
    final addressController =
        TextEditingController(text: settings.companyAddress);
    final phoneController = TextEditingController(text: settings.companyPhone);
    final emailController = TextEditingController(text: settings.companyEmail);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Company Information'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(settingsProvider.notifier).updateCompanyInfo(
                    name: nameController.text,
                    address: addressController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                  );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLanguageRegionDialog() {
    final settings = ref.watch(settingsProvider);
    String selectedLanguage = settings.language;
    String selectedRegion = settings.region;

    final languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];
    final regions = ['US', 'ES', 'FR', 'DE', 'CN'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Language & Region'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedLanguage,
              decoration: const InputDecoration(labelText: 'Language'),
              items: languages
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      ))
                  .toList(),
              onChanged: (value) =>
                  selectedLanguage = value ?? selectedLanguage,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedRegion,
              decoration: const InputDecoration(labelText: 'Region'),
              items: regions
                  .map((reg) => DropdownMenuItem(
                        value: reg,
                        child: Text(reg),
                      ))
                  .toList(),
              onChanged: (value) => selectedRegion = value ?? selectedRegion,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(settingsProvider.notifier)
                  .updateLanguageAndRegion(selectedLanguage, selectedRegion);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showTimeZoneDialog() {
    final settings = ref.watch(settingsProvider);
    String selectedTimeZone = settings.timeZone;

    final timeZones = [
      'UTC-12',
      'UTC-11',
      'UTC-10',
      'UTC-9',
      'UTC-8',
      'UTC-7',
      'UTC-6',
      'UTC-5',
      'UTC-4',
      'UTC-3',
      'UTC-2',
      'UTC-1',
      'UTC+0',
      'UTC+1',
      'UTC+2',
      'UTC+3',
      'UTC+4',
      'UTC+5',
      'UTC+6',
      'UTC+7',
      'UTC+8',
      'UTC+9',
      'UTC+10',
      'UTC+11',
      'UTC+12'
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time Zone'),
        content: DropdownButtonFormField<String>(
          value: selectedTimeZone,
          items: timeZones
              .map((tz) => DropdownMenuItem(
                    value: tz,
                    child: Text(tz),
                  ))
              .toList(),
          onChanged: (value) => selectedTimeZone = value ?? selectedTimeZone,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(settingsProvider.notifier)
                  .updateTimeZone(selectedTimeZone);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
