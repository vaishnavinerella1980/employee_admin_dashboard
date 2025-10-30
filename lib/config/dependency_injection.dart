import 'package:employee_admin_dashboard/data/auth_api.dart';
import 'package:employee_admin_dashboard/data/employee_api.dart';
import 'package:employee_admin_dashboard/data/employee_local_datasource.dart';
import 'package:employee_admin_dashboard/data/employee_remote_datasource.dart';
import 'package:employee_admin_dashboard/data/local/local_database.dart';
import 'package:employee_admin_dashboard/data/providers/employee_repository.dart';
import 'package:employee_admin_dashboard/data/providers/employee_repository_interface.dart';
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository.dart';
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository_interface.dart';
import 'package:employee_admin_dashboard/data/reports_api.dart';
import 'package:employee_admin_dashboard/data/time_tracking_api.dart';
import 'package:employee_admin_dashboard/data/time_tracking_local_datasource.dart';
import 'package:employee_admin_dashboard/data/time_tracking_remote_datasource.dart';
import 'package:employee_admin_dashboard/domain/employee/get_all_employees.dart';
import 'package:employee_admin_dashboard/domain/employee/create_employee.dart';
import 'package:employee_admin_dashboard/domain/employee/update_employee.dart';
import 'package:employee_admin_dashboard/domain/employee/delete_employee.dart';
import 'package:employee_admin_dashboard/domain/employee_tracking/clock_in_employee.dart';
import 'package:employee_admin_dashboard/domain/employee_tracking/clock_out_employee.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../core/network/api_client.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // 1. Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // 2. Register Database
  final database = await LocalDatabase.initialize();
  getIt.registerSingleton<LocalDatabase>(database);

  // 3. Register API Client
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(getIt<SharedPreferences>()),
  );

  // 4. Register Dio
  getIt.registerLazySingleton<Dio>(
    () => getIt<ApiClient>().dio,
  );

  // 5. Register API Services
  getIt.registerLazySingleton<EmployeeApi>(
    () => EmployeeApi(getIt<Dio>()),
  );

  getIt.registerLazySingleton<TimeTrackingApi>(
    () => TimeTrackingApi(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthApi>(
    () => AuthApi(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ReportsApi>(
    () => ReportsApi(getIt<Dio>()),
  );

  // 6. Register Local DataSources
  getIt.registerLazySingleton<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(getIt<LocalDatabase>()),
  );

  getIt.registerLazySingleton<TimeTrackingLocalDataSource>(
    () => TimeTrackingLocalDataSourceImpl(getIt<LocalDatabase>()),
  );

  // 7. Register Remote DataSources
  getIt.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(getIt<EmployeeApi>()),
  );

  getIt.registerLazySingleton<TimeTrackingRemoteDataSource>(
    () => TimeTrackingRemoteDataSourceImpl(getIt<TimeTrackingApi>()),
  );

  // 8. Register Repositories
  getIt.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      localDataSource: getIt<EmployeeLocalDataSource>(),
      remoteDataSource: getIt<EmployeeRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<TimeTrackingRepository>(
    () => TimeTrackingRepositoryImpl(
      localDataSource: getIt<TimeTrackingLocalDataSource>(),
      remoteDataSource: getIt<TimeTrackingRemoteDataSource>(),
    ),
  );

  // 9. Register Use Cases
  getIt.registerLazySingleton<GetAllEmployees>(
    () => GetAllEmployees(getIt<EmployeeRepository>()),
  );

  getIt.registerLazySingleton<CreateEmployee>(
    () => CreateEmployee(getIt<EmployeeRepository>()),
  );

  getIt.registerLazySingleton<UpdateEmployee>(
    () => UpdateEmployee(getIt<EmployeeRepository>()),
  );

  getIt.registerLazySingleton<DeleteEmployee>(
    () => DeleteEmployee(getIt<EmployeeRepository>()),
  );

  getIt.registerLazySingleton<ClockInEmployee>(
    () => ClockInEmployee(getIt<TimeTrackingRepository>()),
  );

  getIt.registerLazySingleton<ClockOutEmployee>(
    () => ClockOutEmployee(getIt<TimeTrackingRepository>()),
  );
}
