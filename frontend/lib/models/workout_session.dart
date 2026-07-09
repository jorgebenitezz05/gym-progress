class WorkoutSession {
  final int id;
  final int routineId;
  final String routineName;
  final String workoutDate;
  final String notes;
  final String createdAt;

  WorkoutSession({
    required this.id,
    required this.routineId,
    required this.routineName,
    required this.workoutDate,
    required this.notes,
    required this.createdAt,
  });

  factory WorkoutSession.fromJson(Map<String, dynamic> json) {
    return WorkoutSession(
      id: json['id'],
      routineId: json['routineId'],
      routineName: json['routineName'] ?? '',
      workoutDate: json['workoutDate'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}