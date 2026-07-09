class RoutineExercise {
  final int id;

  final int routineId;
  final String routineName;

  final int exerciseId;
  final String exerciseName;
  final String muscleGroup;

  final int exerciseOrder;
  final int targetSets;
  final String targetRepetitions;
  final int? restSeconds;
  final String? notes;

  RoutineExercise({
    required this.id,
    required this.routineId,
    required this.routineName,
    required this.exerciseId,
    required this.exerciseName,
    required this.muscleGroup,
    required this.exerciseOrder,
    required this.targetSets,
    required this.targetRepetitions,
    required this.restSeconds,
    required this.notes,
  });

  factory RoutineExercise.fromJson(Map<String, dynamic> json) {
    return RoutineExercise(
      id: json['id'],
      routineId: json['routineId'],
      routineName: json['routineName'] ?? '',
      exerciseId: json['exerciseId'],
      exerciseName: json['exerciseName'] ?? '',
      muscleGroup: json['muscleGroup'] ?? '',
      exerciseOrder: json['exerciseOrder'] ?? 0,
      targetSets: json['targetSets'] ?? 0,
      targetRepetitions: json['targetRepetitions'] ?? '',
      restSeconds: json['restSeconds'],
      notes: json['notes'],
    );
  }
}