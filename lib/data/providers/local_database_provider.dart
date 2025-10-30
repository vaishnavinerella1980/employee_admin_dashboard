import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../data/local/local_database.dart';
import '../../config/dependency_injection.dart';

// Local database provider
final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return getIt<LocalDatabase>();
});
