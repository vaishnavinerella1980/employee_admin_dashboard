import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/data/providers/employee_repository_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteEmployee {
  final EmployeeRepository repository;

  DeleteEmployee(this.repository);

  Future<Either<Failure, void>> call(String employeeId) async {
    return await repository.deleteEmployee(employeeId);
  }
}
