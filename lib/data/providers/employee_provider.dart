import 'package:employee_admin_dashboard/domain/employee/get_all_employees.dart';
import 'package:employee_admin_dashboard/domain/employee/create_employee.dart';
import 'package:employee_admin_dashboard/domain/employee/update_employee.dart';
import 'package:employee_admin_dashboard/domain/employee/delete_employee.dart';
import 'package:employee_admin_dashboard/domain/entities/employee_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../config/dependency_injection.dart';

part 'employee_provider.freezed.dart';

final employeeProvider = NotifierProvider<EmployeeNotifier, EmployeeState>(() {
  return EmployeeNotifier();
});

class EmployeeNotifier extends Notifier<EmployeeState> {
  late final GetAllEmployees _getAllEmployees;
  late final CreateEmployee _createEmployee;
  late final UpdateEmployee _updateEmployee;
  late final DeleteEmployee _deleteEmployee;

  @override
  EmployeeState build() {
    _getAllEmployees = getIt<GetAllEmployees>();
    _createEmployee = getIt<CreateEmployee>();
    _updateEmployee = getIt<UpdateEmployee>();
    _deleteEmployee = getIt<DeleteEmployee>();
    return const EmployeeState.initial();
  }

  Future<void> loadEmployees() async {
    state = const EmployeeState.loading();

    final result = await _getAllEmployees();

    result.fold(
      (failure) => state = EmployeeState.error(failure.message),
      (employees) => state = EmployeeState.loaded(employees),
    );
  }

  void searchEmployees(String query) {
    state = state.maybeMap(
      loaded: (loadedState) {
        final filteredEmployees = loadedState.employees
            .where((employee) =>
                employee.name.toLowerCase().contains(query.toLowerCase()) ||
                employee.department
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                employee.position.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return EmployeeState.loaded(filteredEmployees);
      },
      orElse: () => state,
    );
  }

  Future<void> createEmployee(EmployeeEntity employee) async {
    state = const EmployeeState.loading();

    final result = await _createEmployee(employee);

    result.fold(
      (failure) => state = EmployeeState.error(failure.message),
      (createdEmployee) {
        state = state.maybeMap(
          loaded: (loadedState) {
            final updatedEmployees = [
              ...loadedState.employees,
              createdEmployee
            ];
            return EmployeeState.loaded(updatedEmployees);
          },
          orElse: () => EmployeeState.loaded([createdEmployee]),
        );
      },
    );
  }

  Future<void> updateEmployee(EmployeeEntity employee) async {
    state = const EmployeeState.loading();

    final result = await _updateEmployee(employee);

    result.fold(
      (failure) => state = EmployeeState.error(failure.message),
      (updatedEmployee) {
        state = state.maybeMap(
          loaded: (loadedState) {
            final updatedEmployees = loadedState.employees.map((e) {
              return e.id == employee.id ? updatedEmployee : e;
            }).toList();
            return EmployeeState.loaded(updatedEmployees);
          },
          orElse: () => state,
        );
      },
    );
  }

  Future<void> deleteEmployee(String employeeId) async {
    final result = await _deleteEmployee(employeeId);

    result.fold(
      (failure) => state = EmployeeState.error(failure.message),
      (_) {
        state = state.maybeMap(
          loaded: (loadedState) {
            final updatedEmployees =
                loadedState.employees.where((e) => e.id != employeeId).toList();
            return EmployeeState.loaded(updatedEmployees);
          },
          orElse: () => state,
        );
      },
    );
  }
}

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState.initial() = _Initial;
  const factory EmployeeState.loading() = _Loading;
  const factory EmployeeState.loaded(List<EmployeeEntity> employees) = _Loaded;
  const factory EmployeeState.error(String message) = _Error;
}
