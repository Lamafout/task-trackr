class TimeRequest {
final String desciption;
final int duration;
final String employeeID;
final String taskID;

const TimeRequest({required this.taskID, required this.desciption, required this.duration, required this.employeeID});

Map<String, dynamic> toJSON() {
  return {
    'descrition': desciption,
    'duration': duration,
    'employeeID': employeeID,
    'taskID': taskID
  };
}
}