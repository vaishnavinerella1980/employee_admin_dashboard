// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:employee_admin_dashboard/core/network/api_client.dart' as _i691;
import 'package:employee_admin_dashboard/data/employee_api.dart' as _i239;
import 'package:employee_admin_dashboard/data/employee_local_datasource.dart'
    as _i322;
import 'package:employee_admin_dashboard/data/employee_remote_datasource.dart'
    as _i1056;
import 'package:employee_admin_dashboard/data/local/local_database.dart'
    as _i1057;
import 'package:employee_admin_dashboard/data/providers/employee_repository.dart'
    as _i939;
import 'package:employee_admin_dashboard/data/providers/employee_repository_interface.dart'
    as _i881;
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository.dart'
    as _i612;
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository_interface.dart'
    as _i592;
import 'package:employee_admin_dashboard/data/time_tracking_api.dart' as _i820;
import 'package:employee_admin_dashboard/data/time_tracking_local_datasource.dart'
    as _i240;
import 'package:employee_admin_dashboard/data/time_tracking_remote_datasource.dart'
    as _i168;
import 'package:employee_admin_dashboard/domain/employee/get_all_employees.dart'
    as _i578;
import 'package:employee_admin_dashboard/domain/employee_tracking/clock_in_employee.dart'
    as _i354;
import 'package:employee_admin_dashboard/domain/employee_tracking/clock_out_employee.dart'
    as _i238;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1057.LocalDatabase>(() => _i1057.LocalDatabase());
    gh.lazySingleton<_i240.TimeTrackingLocalDataSource>(() =>
        _i240.TimeTrackingLocalDataSourceImpl(gh<_i1057.LocalDatabase>()));
    gh.singleton<_i691.ApiClient>(
        () => _i691.ApiClient(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i1056.EmployeeRemoteDataSource>(
        () => _i1056.EmployeeRemoteDataSourceImpl(gh<_i239.EmployeeApi>()));
    gh.lazySingleton<_i322.EmployeeLocalDataSource>(
        () => _i322.EmployeeLocalDataSourceImpl(gh<_i1057.LocalDatabase>()));
    gh.lazySingleton<_i881.EmployeeRepository>(
        () => _i939.EmployeeRepositoryImpl(
              localDataSource: gh<_i322.EmployeeLocalDataSource>(),
              remoteDataSource: gh<_i1056.EmployeeRemoteDataSource>(),
            ));
    gh.lazySingleton<_i168.TimeTrackingRemoteDataSource>(() =>
        _i168.TimeTrackingRemoteDataSourceImpl(gh<_i820.TimeTrackingApi>()));
    gh.lazySingleton<_i592.TimeTrackingRepository>(
        () => _i612.TimeTrackingRepositoryImpl(
              localDataSource: gh<_i240.TimeTrackingLocalDataSource>(),
              remoteDataSource: gh<_i168.TimeTrackingRemoteDataSource>(),
            ));
    gh.factory<_i578.GetAllEmployees>(
        () => _i578.GetAllEmployees(gh<_i881.EmployeeRepository>()));
    gh.factory<_i354.ClockInEmployee>(
        () => _i354.ClockInEmployee(gh<_i592.TimeTrackingRepository>()));
    gh.factory<_i238.ClockOutEmployee>(
        () => _i238.ClockOutEmployee(gh<_i592.TimeTrackingRepository>()));
    return this;
  }
}
