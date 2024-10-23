class TimeRequest {
final String description;
final int duration;
final String employeeID;
final String taskID;

const TimeRequest({required this.taskID, required this.description, required this.duration, required this.employeeID});

Map<String, dynamic> toJSON() {
  return {
    'description': description,
    'duration': duration,
    'employeeID': employeeID,
    'taskID': taskID
  };
}
}