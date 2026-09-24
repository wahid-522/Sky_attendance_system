import 'package:flutter/material.dart';
import '../../core/session/app_session.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../domain/entities/student_entity.dart';

class AttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  int  _selectedNavIndex = 0;
  bool _isSubmitting     = false;

  int  get selectedNavIndex => _selectedNavIndex;
  bool get isSubmitting     => _isSubmitting;
  bool get isReady          => _students.isNotEmpty;

  late List<StudentEntity> _students;
  List<StudentEntity> get students => _students;

  String _className = '';
  String _subject   = '';

  String get sessionTitle => _subject.isNotEmpty && _className.isNotEmpty
      ? 'Class $_className - $_subject'
      : 'Mark Attendance';

  String get sessionDate {
    final now = DateTime.now();
    const days   = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    const months = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final day = days[now.weekday - 1];
    return '$day, ${months[now.month]} ${now.day}, ${now.year}';
  }

  int get presentCount =>
      _students.where((s) => s.status == AttendanceStatus.present).length;
  int get absentCount =>
      _students.where((s) => s.status == AttendanceStatus.absent).length;

  AttendanceViewModel() {
    _initStudents();

    // Read class + subject from session — set by SubjectCard.onTap before navigation
    final classId = AppSession.instance.selectedClassId;
    final subject = AppSession.instance.selectedSubject;

    if (classId.isNotEmpty && subject.isNotEmpty) {
      _className = classId;
      _subject   = subject;
      _loadStudents(classId, subject);
    }
  }

  void _initStudents() {
    _students = []; // start empty — real students loaded from API
  }

  Future<void> _loadStudents(String classId, String subject) async {
    try {
      final list = await _repo.getStudentsForSession(classId, subject);
      if (list.isNotEmpty) {
        _students = list;
        notifyListeners();
      }
    } catch (_) {
      // Keep placeholder list on error
    }
  }

  Future<void> loadStudents(String classId, String subjectName) {
    _className = classId;
    _subject   = subjectName;
    return _loadStudents(classId, subjectName);
  }

  void markAllPresent() {
    _students = _students
        .map((s) => s.copyWith(status: AttendanceStatus.present))
        .toList();
    notifyListeners();
  }

  void markAllAbsent() {
    _students = _students
        .map((s) => s.copyWith(status: AttendanceStatus.absent))
        .toList();
    notifyListeners();
  }

  void toggleStudentStatus(String id, AttendanceStatus status) {
    _students = _students.map((s) {
      if (s.id == id) return s.copyWith(status: status);
      return s;
    }).toList();
    notifyListeners();
  }

  void selectTab(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  /// Matches original view API: submitAttendance({required VoidCallback onSuccess})
  void submitAttendance({required VoidCallback onSuccess}) {
    // Block submit if no students loaded
    if (_students.isEmpty) return;

    _isSubmitting = true;
    notifyListeners();

    _repo
        .submitAttendance(
          className: _className,
          subject:   _subject,
          students:  _students,
        )
        .then((response) {
          // Store response in session so confirmation view can read it
          AppSession.instance.lastSubmitResponse = response;
          _isSubmitting = false;
          notifyListeners();
          onSuccess();
        })
        .catchError((_) {
          // On error, navigate anyway (original behaviour preserved)
          AppSession.instance.lastSubmitResponse = null;
          _isSubmitting = false;
          notifyListeners();
          onSuccess();
        });
  }
}
