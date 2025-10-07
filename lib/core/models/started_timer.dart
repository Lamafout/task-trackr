import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_trackr/core/models/task_class.dart';

part 'started_timer.g.dart';

@HiveType(typeId: 4)
class StartedTimer {
  @HiveField(0)
  final TaskClass task;
  @HiveField(1)
  final String startTime;

  StartedTimer({
    required this.task,
    required this.startTime,
  });
}