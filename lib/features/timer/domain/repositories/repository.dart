import 'package:task_trackr/index.dart';

abstract class TimerRepository {
  Future<Either<Failure, void>> writeOffTime(TimeRequest request);
}