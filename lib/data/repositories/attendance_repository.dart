import '../datasources/remote/app_api_service.dart';
import '../models/class_model.dart';
import '../models/subject_model.dart';
import '../models/student_model.dart';
import '../models/attendance_session_model.dart';
import '../../domain/entities/student_entity.dart';

class AttendanceRepository {
  final AppApiService _api = AppApiService.instance;

  // ── Classes ───────────────────────────────────────────────────────────────
  Future<List<ClassModel>> getMyClasses() async {
    final data = await _api.getMyClasses();
    return data
        .map((e) => ClassModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Subjects ──────────────────────────────────────────────────────────────
  Future<List<SubjectModel>> getSubjectsForClass(String classId) async {
    final data = await _api.getSubjectsForClass(classId);
    final list = data['subjects'] as List<dynamic>? ?? [];
    return list
        .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Students for live attendance ──────────────────────────────────────────
  /// Returns domain entities (StudentEntity) directly — compatible with
  /// existing AttendanceViewModel and StudentAttendanceTile widget.
  Future<List<StudentEntity>> getStudentsForSession(
    String classId,
    String subject,
  ) async {
    final data = await _api.getStudentsForSession(classId, subject);
    final list = data['students'] as List<dynamic>? ?? [];
    return list
        .map((e) => StudentModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }

  // ── Submit attendance ─────────────────────────────────────────────────────
  /// [students] is the final list after instructor marked present/absent.
  /// Returns the confirmation data from backend.
  Future<Map<String, dynamic>> submitAttendance({
    required String className,
    required String subject,
    required List<StudentEntity> students,
  }) async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final records = students
        .map((s) => {
              'studentId': s.id,
              'status':
                  s.status == AttendanceStatus.present ? 'Present' : 'Absent',
            })
        .toList();

    return _api.submitAttendance(
      className: className,
      subject:   subject,
      date:      today,
      records:   records,
    );
  }

  // ── History ───────────────────────────────────────────────────────────────
  Future<List<AttendanceSessionModel>> getHistory() async {
    final data = await _api.getAttendanceHistory();
    return data
        .map((e) => AttendanceSessionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Session detail ────────────────────────────────────────────────────────
  Future<AttendanceSessionDetailModel> getSessionDetail(
      String sessionId) async {
    final data = await _api.getSessionDetail(sessionId);
    return AttendanceSessionDetailModel.fromJson(data);
  }
}
