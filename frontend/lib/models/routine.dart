class Routine {
  final int id;
  final String name;
  final String description;
  final String createdAt;

  Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}