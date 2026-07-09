class Exercise {
  final int id;
  final String name;
  final String muscleGroup;
  final String description;

  Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.description,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'] ?? '',
      muscleGroup: json['muscleGroup'] ?? '',
      description: json['description'] ?? '',
    );
  }
}