class WorkoutSet {
  final int id;
  final int workoutSessionId;
  final int exerciseId;
  final String exerciseName;
  final String muscleGroup;
  final int setNumber;
  final double weightKg;
  final int repetitions;
  final double volume;
  final String notes;

  WorkoutSet({
    required this.id,
    required this.workoutSessionId,
    required this.exerciseId,
    required this.exerciseName,
    required this.muscleGroup,
    required this.setNumber,
    required this.weightKg,
    required this.repetitions,
    required this.volume,
    required this.notes,
  });

  factory WorkoutSet.fromJson(Map<String, dynamic> json) {
    return WorkoutSet(
      id: json['id'],
      workoutSessionId: json['workoutSessionId'],
      exerciseId: json['exerciseId'],
      exerciseName: json['exerciseName'] ?? '',
      muscleGroup: json['muscleGroup'] ?? '',
      setNumber: json['setNumber'] ?? 0,
      weightKg: (json['weightKg'] ?? 0).toDouble(),
      repetitions: json['repetitions'] ?? 0,
      volume: (json['volume'] ?? 0).toDouble(),
      notes: json['notes'] ?? '',
    );
  }
}