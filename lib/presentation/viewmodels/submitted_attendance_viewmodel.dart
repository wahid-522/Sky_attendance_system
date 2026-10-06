import 'package:flutter/material.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../domain/entities/attendance_record_entity.dart';

class SubmittedAttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  // ── Getters expected by SubmittedAttendanceView ───────────────────────────
  int    get totalStudents  => _totalStudents;
  int    get presentCount   => _presentCount;
  int    get absentCount    => _absentCount;
  String get attendanceRate => _attendanceRate;
  String get sessionTitle   => _sessionTitle;
  String get sessionSubtitle => _sessionSubtitle;

  List<StudentAttendanceRecord> get students => _students;

  int    _totalStudents   = 0;
  int    _presentCount    = 0;
  int    _absentCount     = 0;
  String _attendanceRate  = '0.0%';
  String _sessionTitle    = 'Submitted Attendance';
  String _sessionSubtitle = 'No sessions yet';
  List<StudentAttendanceRecord> _students = const [];

  SubmittedAttendanceViewModel() {
    _loadLatestSession();
  }

  /// Load the most recent submitted session automatically
  Future<void> _loadLatestSession() async {
    try {
      final history = await _repo.getHistory();
      if (history.isEmpty) return;

      // Most recent session is first (API returns desc order)
      final latest = history.first;
      await _loadSession(latest.sessionId);
    } catch (_) {
      // Keep empty state on error
    }
  }

  Future<void> _loadSession([String? sessionId]) async {
    if (sessionId == null || sessionId.isEmpty) return;
    try {
      final detail = await _repo.getSessionDetail(sessionId);
      _totalStudents  = detail.totalStudents;
      _presentCount   = detail.presentCount;
      _absentCount    = detail.absentCount;
      _attendanceRate = detail.attendanceRate;

      // Build real title and subtitle
      final d = detail.date;
      const months = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      _sessionTitle   = 'Submitted Attendance\n- ${months[d.month]} ${d.day}, ${d.year}';
      _sessionSubtitle = '${detail.className}, ${detail.subject}';
      _students = detail.students
          .map((s) => StudentAttendanceRecord(
                id:        s.id,
                name:      s.name,
                initials:  _initials(s.name),
                studentId: s.studentId,
                isPresent: s.isPresent,
              ))
          .toList();
      notifyListeners();
    } catch (_) {
      // Keep current state on error
    }
  }

  /// Called externally when a specific sessionId is passed via navigation
  void loadSession(String sessionId) => _loadSession(sessionId);

  static String _initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
