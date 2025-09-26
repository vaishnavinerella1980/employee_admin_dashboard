import 'package:dartz/dartz.dart';
import 'package:employee_admin_dashboard/core/utils/failures.dart';
import 'package:employee_admin_dashboard/data/providers/time_tracking_repository_interface.dart';
import 'package:employee_admin_dashboard/domain/entities/time_record_entity.dart';
import 'package:injectable/injectable.dart';


@injectable
class ClockInEmployee {
  final TimeTrackingRepository repository;

  ClockInEmployee(this.repository);

  Future<Either<Failure, TimeRecordEntity>> call(ClockInParams params) async {
    return await repository.clockIn(
      params.employeeId,
      location: params.location,
    );
  }
}

class ClockInParams {
  final String employeeId;
  final String? location;

  ClockInParams({
    required this.employeeId,
    this.location,
  });
}