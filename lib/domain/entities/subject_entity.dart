class SubjectEntity {
  final String id;
  final String name;
  final String description;
  final String category; // e.g. 'Core', 'Language'
  final int enrolledCount;
  final String symbolType; // 'math', 'physics', 'literature'

  const SubjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.enrolledCount,
    required this.symbolType,
  });
}
