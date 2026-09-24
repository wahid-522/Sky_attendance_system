import '../../domain/entities/student_entity.dart';

class StudentModel {
  final String id;
  final String name;
  final String rollNumber;
  final AttendanceStatus status;

  const StudentModel({
    required this.id,
    required this.name,
    required this.rollNumber,
    this.status = AttendanceStatus.present,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['status']?.toString().toLowerCase() ?? 'present';
    return StudentModel(
      id:         json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name:       json['name']?.toString() ?? '',
      rollNumber: json['rollNumber']?.toString() ?? '',
      status:     rawStatus == 'absent'
                    ? AttendanceStatus.absent
                    : AttendanceStatus.present,
    );
  }

  /// Convert to domain entity used by existing UI widgets
  StudentEntity toEntity() => StudentEntity(
        id:         id,
        name:       name,
        rollNumber: rollNumber,
        status:     status,
      );
}
