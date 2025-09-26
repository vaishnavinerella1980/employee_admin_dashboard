import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository_interface.dart';
import 'package:employee_admin_dashboard/domain/entities/time_record_entity.dart';
import 'package:injectable/injectable.dart';


@injectable
class ClockOutEmployee {
  final TimeTrackingRepository repository;

  ClockOutEmployee(this.repository);

  Future<Either<Failure, TimeRecordEntity>> call(ClockOutParams params) async {
    return await repository.clockOut(params.employeeId, params.recordId);
  }
}

class ClockOutParams {
  final String employeeId;
  final String recordId;

  ClockOutParams({
    required this.employeeId,
    required this.recordId,
  });
}