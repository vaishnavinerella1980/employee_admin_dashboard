import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/data/providers/employee_repository_interface.dart';
import 'package:employee_admin_dashboard/domain/entities/employee_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetAllEmployees {
  final EmployeeRepository repository;

  GetAllEmployees(this.repository);

  Future<Either<Failure, List<EmployeeEntity>>> call() async {
    return await repository.getAllEmployees();
  }
}