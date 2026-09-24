import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/attendance_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository       _authRepo       = AuthRepository();
  final AttendanceRepository _attendanceRepo = AttendanceRepository();

  // ── Getters expected by ProfileView ──────────────────────────────────────
  String get teacherName  => _teacherName;
  String get teacherEmail => _teacherEmail;
  String get teacherRole  => _teacherRole;
  String get department   => _department;
  String get employeeId   => _employeeId;
  String get semester     => _semester;

  /// assignedClasses — maps with 'name', 'subject', 'students' keys
  List<Map<String, String>> get assignedClasses => _assignedClasses;

  // ── Internal state ────────────────────────────────────────────────────────
  String _teacherName  = 'Instructor';
  String _teacherEmail = '';
  String _teacherRole  = 'Instructor';
  String _department   = '—';
  String _employeeId   = '—';
  String _semester     = 'Term 2026';

  List<Map<String, String>> _assignedClasses = const [];

  ProfileViewModel() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final instructor = await _authRepo.getProfile();

      _teacherName  = instructor.name;
      _teacherEmail = instructor.email;
      _teacherRole  = instructor.qualification.isNotEmpty
          ? instructor.qualification
          : 'Instructor';
      _department   = instructor.subjects.isNotEmpty
          ? instructor.subjects.join(', ')
          : '—';
      _employeeId   = instructor.id;
      _semester     = 'Term ${DateTime.now().year}';

      // Build assignedClasses with real student counts + subjects per class
      if (instructor.classes.isNotEmpty) {
        final classData = await Future.wait(
          instructor.classes.map((cls) async {
            try {
              // Get subjects for this class from timetable
              final subjectModels =
                  await _attendanceRepo.getSubjectsForClass(cls);
              final subjectNames = subjectModels.isNotEmpty
                  ? subjectModels.map((s) => s.name).join(', ')
                  : instructor.subjects.isNotEmpty
                      ? instructor.subjects.join(', ')
                      : '—';

              // Student count from subjects (enrolledCount from first subject)
              final studentCount = subjectModels.isNotEmpty
                  ? subjectModels.first.enrolledCount
                  : 0;

              return {
                'name':     cls,
                'subject':  subjectNames,
                'students': '$studentCount students',
              };
            } catch (_) {
              return {
                'name':     cls,
                'subject':  instructor.subjects.join(', '),
                'students': '—',
              };
            }
          }),
        );
        _assignedClasses = classData;
      } else {
        _assignedClasses = const [
          {'name': 'No classes assigned', 'subject': '—', 'students': '—'},
        ];
      }

      notifyListeners();
    } catch (_) {
      // Keep defaults on error
    }
  }
}
