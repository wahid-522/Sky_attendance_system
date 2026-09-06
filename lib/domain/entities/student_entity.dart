enum AttendanceStatus { present, absent }

class StudentEntity {
  final String id;
  final String name;
  final String rollNumber;
  final AttendanceStatus status;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.rollNumber,
    this.status = AttendanceStatus.present,
  });

  StudentEntity copyWith({
    String? id,
    String? name,
    String? rollNumber,
    AttendanceStatus? status,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      rollNumber: rollNumber ?? this.rollNumber,
      status: status ?? this.status,
    );
  }
}
