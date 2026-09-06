class StudentAttendanceRecord {
  final String id;
  final String name;
  final String initials;
  final String studentId;
  final bool isPresent;

  const StudentAttendanceRecord({
    required this.id,
    required this.name,
    required this.initials,
    required this.studentId,
    required this.isPresent,
  });
}
