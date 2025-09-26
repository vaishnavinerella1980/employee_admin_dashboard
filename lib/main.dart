import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/environment.dart';
import 'config/dependency_injection.dart';
import 'data/local/local_database.dart';
import 'app.dart';

void main() async {
  try {
    // Ensure Flutter binding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    print('Initializing app...');

    // 1. Initialize environment first
    await Environment.initialize();
    print(' Environment initialized');

    // 2. Initialize local database (Hive)
    await LocalDatabase.initialize();
    print(' Local database initialized');

    // 3. Configure dependency injection
    await configureDependencies();
    print('Dependencies configured');

    print(' App initialization complete');

    runApp(
      ProviderScope(
        child: EmployeeTimeTrackingApp(),
      ),
    );
  } catch (e, stackTrace) {
    // Handle initialization errors gracefully
    print('âŒ Initialization error: $e');
    print('Stack trace: $stackTrace');

    runApp(
      MaterialApp(
        title: 'Initialization Error',
        home: Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to initialize the app',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Restart the app
                      main();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
