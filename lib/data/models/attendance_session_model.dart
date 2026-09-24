/// History list item — one row in AttendanceHistoryView
class AttendanceSessionModel {
  final String sessionId;
  final String className;
  final String subject;
  final DateTime date;
  final int presentCount;
  final int absentCount;
  final int totalStudents;

  const AttendanceSessionModel({
    required this.sessionId,
    required this.className,
    required this.subject,
    required this.date,
    required this.presentCount,
    required this.absentCount,
    required this.totalStudents,
  });

  factory AttendanceSessionModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSessionModel(
      sessionId:    json['sessionId']?.toString() ?? '',
      className:    json['class']?.toString()     ?? '',
      subject:      json['subject']?.toString()   ?? '',
      date:         DateTime.tryParse(json['date']?.toString() ?? '') ??
                    DateTime.now(),
      presentCount: (json['presentCount']  as num?)?.toInt() ?? 0,
      absentCount:  (json['absentCount']   as num?)?.toInt() ?? 0,
      totalStudents:(json['totalStudents'] as num?)?.toInt() ?? 0,
    );
  }

  String get dateTitle {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month]} ${date.day}, ${date.year}';
  }

  String get subtitle => '$subject · $className';
}

/// Submitted session detail — for SubmittedAttendanceView
class AttendanceSessionDetailModel {
  final String sessionId;
  final String className;
  final String subject;
  final DateTime date;
  final int presentCount;
  final int absentCount;
  final int totalStudents;
  final String attendanceRate;
  final List<SessionStudentModel> students;

  const AttendanceSessionDetailModel({
    required this.sessionId,
    required this.className,
    required this.subject,
    required this.date,
    required this.presentCount,
    required this.absentCount,
    required this.totalStudents,
    required this.attendanceRate,
    required this.students,
  });

  factory AttendanceSessionDetailModel.fromJson(Map<String, dynamic> json) {
    final studentList = (json['students'] as List<dynamic>?)
            ?.map((e) => SessionStudentModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return AttendanceSessionDetailModel(
      sessionId:     json['sessionId']?.toString()     ?? '',
      className:     json['class']?.toString()         ?? '',
      subject:       json['subject']?.toString()       ?? '',
      date:          DateTime.tryParse(json['date']?.toString() ?? '') ??
                     DateTime.now(),
      presentCount:  (json['presentCount']   as num?)?.toInt() ?? 0,
      absentCount:   (json['absentCount']    as num?)?.toInt() ?? 0,
      totalStudents: (json['totalStudents']  as num?)?.toInt() ?? 0,
      attendanceRate: json['attendanceRate']?.toString() ?? '0.0%',
      students:       studentList,
    );
  }
}

/// One student record inside a submitted session
class SessionStudentModel {
  final String id;
  final String name;
  final String studentId;  // roll number / regNo
  final bool isPresent;

  const SessionStudentModel({
    required this.id,
    required this.name,
    required this.studentId,
    required this.isPresent,
  });

  factory SessionStudentModel.fromJson(Map<String, dynamic> json) {
    return SessionStudentModel(
      id:        json['id']?.toString()        ?? '',
      name:      json['name']?.toString()      ?? '',
      studentId: json['studentId']?.toString() ?? '',
      isPresent: json['isPresent'] as bool?    ?? false,
    );
  }
}
